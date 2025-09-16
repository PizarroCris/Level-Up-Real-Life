class Profile < ApplicationRecord
  DEFAULT_ATTACK = 100
  DEFAULT_DEFENSE = 100

  belongs_to :user
  belongs_to :map_plot, optional: true
  
  has_one :guild_membership, dependent: :destroy
  has_one :guild, through: :guild_membership

  has_many :buildings, dependent: :destroy
  has_many :equipments, dependent: :destroy
  has_many :equipment_items, through: :equipments
  has_many :troops, through: :buildings

  def total_attack
    DEFAULT_ATTACK + troop_attack_bonus + equipment_attack_bonus
  end

  def total_defense
    DEFAULT_DEFENSE + troop_defense_bonus + equipment_defense_bonus
  end

  def balance_power
    (total_attack * 0.7) + (total_defense * 0.3)
  end

  def can_afford?(cost)
    return false unless cost
    wood >= cost[:wood] && stone >= cost[:stone] && metal >= cost[:metal]
  end

  def deduct_resources!(cost)
    update!(
      wood: self.wood - cost[:wood],
      stone: self.stone - cost[:stone],
      metal: self.metal - cost[:metal]
    )
  end

  def total_morale
    troops.sum(&:morale)
  end

  def can_fight?
    troops.any? && total_morale > 0
  end

  def max_troops_for_attack
    castle = buildings.find_by(building_type: 'castle')

    return 0 unless castle

    Building::BUILDING_STATS.dig('castle', castle.level, :max_troops_for_attack) || 0
  end

  def unlocked_troops
    barracks = buildings.where(building_type: 'barrack')

    return Troop.none if barracks.empty?

    max_barracks_level = barracks.maximum(:level)
    troops.where("troops.level <= ?", max_barracks_level)
  end

  def speed_bonus
    equipment_bonus = equipments.sum(:speed_bonus) / 100.0
    level_bonus = level * 0.01
    equipment_bonus + level_bonus
  end

  private

  def troop_attack_bonus
    troops.sum(&:attack)
  end

  def troop_defense_bonus
    troops.sum(&:defense)
  end

  def equipment_attack_bonus
    equipment_items.sum(&:attack)
  end

  def equipment_defense_bonus
    equipment_items.sum(&:defense)
  end
end
