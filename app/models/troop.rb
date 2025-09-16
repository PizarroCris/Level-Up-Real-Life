class Troop < ApplicationRecord
  belongs_to :building
  has_one :profile, through: :building

  before_validation :set_stats_from_constant

  validates :troop_type, presence: true

  TROOP_STATS = {
    swordsman: {
      1 => { attack: 10, defense: 15, speed: 1.2, morale: 100 },
      2 => { attack: 14, defense: 21, speed: 1.3, morale: 110 },
      3 => { attack: 20, defense: 30, speed: 1.4, morale: 120 },
      4 => { attack: 28, defense: 42, speed: 1.5, morale: 135 },
      5 => { attack: 40, defense: 60, speed: 1.6, morale: 150 } 
    },
    archer: {
      1 => { attack: 15, defense: 5,  speed: 0.9, morale: 80 }, 
      2 => { attack: 21, defense: 7,  speed: 1.0, morale: 92 }, 
      3 => { attack: 30, defense: 10, speed: 1.1, morale: 105 },
      4 => { attack: 42, defense: 14, speed: 1.2, morale: 120 },
      5 => { attack: 60, defense: 20, speed: 1.3, morale: 140 } 
    },
    cavalry: {
      1 => { attack: 20, defense: 10, speed: 0.6, morale: 120 },
      2 => { attack: 28, defense: 14, speed: 0.7, morale: 130 },
      3 => { attack: 40, defense: 20, speed: 0.8, morale: 140 },
      4 => { attack: 56, defense: 28, speed: 0.9, morale: 155 },
      5 => { attack: 80, defense: 40, speed: 1.0, morale: 175 }
    }
  }.freeze

  validates :troop_type, inclusion: { in: TROOP_STATS.keys.map(&:to_s) }
  validates :level, inclusion: { in: [1, 2, 3, 4, 5] }

  def travel_time_for_distance(distance)
    self.speed * distance
  end

  def morale
    TROOP_STATS.dig(self.troop_type.to_sym, self.level, :morale) || 0
  end

  def image_asset_path
    type = self.troop_type.downcase
    "troops/#{type}/#{type}#{self.level}.png"
  end

  private

  def set_stats_from_constant
    return unless troop_type.present? && level.present?

    stats = TROOP_STATS[self.troop_type.to_sym][self.level]

    if stats
      self.attack  = stats[:attack]
      self.defense = stats[:defense]
      self.speed   = stats[:speed]
    end
  end
end

