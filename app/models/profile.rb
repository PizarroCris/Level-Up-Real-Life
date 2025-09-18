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

  has_many :attacking_battles, class_name: 'Battle', foreign_key: :attacker_id, dependent: :nullify
  has_many :defending_battles, class_name: 'Battle', foreign_key: :defender_id, dependent: :nullify
  has_many :won_battles, class_name: 'Battle', foreign_key: :winner_id, dependent: :nullify

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

  def can_buy?(equipment_item)
    return false unless equipment_item&.price_in_steps
    steps.to_i >= equipment_item.price_in_steps.to_i
  end

  def spend_steps!(amount)
    amount = amount.to_i
    raise ArgumentError, "amount must be positive" if amount <= 0
    with_lock do
      raise "Not enough steps" if steps < amount
      update!(steps: steps - amount)
    end
  end

  def update_resources_from_buildings
    buildings.each do |building|
      resource = building.resources.first
      if resource
        last_collection_time = resource.last_collected_at || Time.now
        time_elapsed_in_hours = (Time.now - last_collection_time) / 3600.0
        produced_amount = (resource.production_per_hour * time_elapsed_in_hours).floor

        current_quantity = send(resource.kind)
        max_storage = resource.storage_capacity

        new_quantity = [current_quantity + produced_amount, max_storage].min
        increment!(resource.kind, new_quantity - current_quantity)
        resource.update!(last_collected_at: Time.now)
      end
    end
  end

  def gain_rewards_from_monster(monster)
    resources_gain = monster.level * 50
    experience_gain = monster.level * 20

    self.wood += resources_gain
    self.stone += resources_gain
    self.metal += resources_gain
    self.experience += experience_gain
    save!
    
    return { wood: resources_gain, stone: resources_gain, metal: resources_gain, experience: experience_gain }
  end

  private

  def base_attack
    attack
  end

  def base_defense
    defense
  end

  def speed_bonus
    equipment_bonus = self.equipments.sum(:speed_bonus) / 100.0
    level_bonus = self.level * 0.01
    equipment_bonus + level_bonus
  end

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
