class Troop < ApplicationRecord
  belongs_to :building
  has_one :profile, through: :building

  TROOP_STATS = {
    archer: { attack: 15, defense: 5 },
    cavalry: { attack: 20, defense: 10 },
    swordsman: { attack: 10, defense: 15 }
  }

  def attack_value
    TROOP_STATS[troop_type.to_sym][:attack] * (1 + level * 0.01)
  end

  def defense_value
    TROOP_STATS[troop_type.to_sym][:defense] * (1 + level * 0.01)
  end
end
