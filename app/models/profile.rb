class Profile < ApplicationRecord
  DEFAULT_ATTACK = 100
  DEFAULT_DEFENSE = 100
  
  belongs_to :user

  has_one :guild_membership
  has_one :guild, through: :guild_membership

  has_many :buildings, dependent: :destroy
  has_many :equipments, dependent: :destroy
  has_many :equipment_items, through: :equipments
  has_many :troops, through: :buildings

  def total_attack
    self.attack + troop_attack_bonus + equipment_attack_bonus
  end

  def total_defense
    self.defense + troop_defense_bonus + equipment_defense_bonus
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
    self.troops.reload.sum(&:morale)
  end

  def can_fight?
    self.troops.any? && self.total_morale > 0
  end

  def max_troops_for_attack
    castle = self.buildings.find_by(building_type: 'castle')

    return 0 unless castle

    Building::BUILDING_STATS.dig('castle', castle.level, :max_troops_for_attack) || 0
  end

  def unlocked_troops
    barracks = self.buildings.where(building_type: 'barrack')

    return Troop.none if barracks.empty?

    max_barracks_level = barracks.maximum(:level)
    self.troops.where("troops.level <= ?", max_barracks_level)
  end

  private

  def base_attack
    attack
  end

  def base_defense
    defense
  end

  def troop_attack_bonus
    total = 0
    troops.each do |troop|
      total += troop.attack_value
    end
    total
  end

  def troop_defense_bonus
    total = 0
    troops.each do |troop|
      total += troop.defense_value
    end
    total
  end

  def equipment_attack_bonus
    total = 0
    equipments.each do |equipment|
      total += equipment.attack
    end
    total
  end

  def equipment_defense_bonus
    total = 0
    equipments.each do |equipment|
      total += equipment.defense
    end
    total
  end

   def speed_bonus
    equipment_bonus = self.equipments.sum(:speed_bonus) / 100.0
    level_bonus = self.level * 0.01
    equipment_bonus + level_bonus
  end

  private

  def troop_attack_bonus
    troops.sum(&:attack_value)
  end

  def troop_defense_bonus
    troops.sum(&:defense_value)
  end

  def equipment_attack_bonus
    equipments.sum(:attack)
  end

  def equipment_defense_bonus
    equipments.sum(:defense)
  end
end
