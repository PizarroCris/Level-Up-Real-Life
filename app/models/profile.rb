class Profile < ApplicationRecord
  DEFAULT_ATTACK = 100
  DEFAULT_DEFENSE = 100

  belongs_to :user
  has_many :buildings, dependent: :destroy
  has_many :equipments, dependent: :destroy
  has_many :troops, through: :buildings

  TROOP_STATS = {
    archer: { attack: 15, defense: 5 },
    cavalry: { attack: 20, defense: 10 },
    swordsman: { attack: 10, defense: 15 }
  }

  def total_attack
    base_attack + troop_attack_bonus + equipment_attack_bonus
  end

  def total_defense
    base_defense + troop_defense_bonus + equipment_defense_bonus
  end

  def balance_power
    (total_attack * 0.7) + (total_defense * 0.3)
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
    buildings.each do |building|
      next unless building.type == "barracks"

      building.troops.each do |troop|
        total += TROOP_STATS[troop.type.to_sym][:attack] * (1 + troop.level * 0.01)
      end
    end
    total
  end

  def troop_defense_bonus
    total = 0
    buildings.each do |building|
      next unless building.type == "barracks"

      building.troops.each do |troop|
        total += TROOP_STATS[troop.type.to_sym][:defense] * (1 + troop.level * 0.01)
      end
    end
    total
  end

  def equipment_attack_bonus
    equipments.sum(&:attack)
  end

  def equipment_defense_bonus
    equipments.sum(&:defense)
  end
end
