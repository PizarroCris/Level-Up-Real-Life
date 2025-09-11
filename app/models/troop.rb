class Troop < ApplicationRecord
  belongs_to :building
  has_one :profile, through: :building

  before_validation :set_stats

  validates :troop_type, presence: true

  TROOP_STATS = {
    archer: { attack: 15, defense: 5 },
    cavalry: { attack: 20, defense: 10 },
    swordsman: { attack: 10, defense: 15 }
  }

  private

  def set_stats
    return unless troop_type.present?
    skills = TROOP_STATS[troop_type.to_sym]
    if skills
      self.attack = skills[:attack] * (1 + level * 0.01)
      self.defense = skills[:defense] * (1 + level * 0.01)
    end
  end
end
