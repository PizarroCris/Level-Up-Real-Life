class Troop < ApplicationRecord
  belongs_to :building
  has_one :profile, through: :building

  before_validation :set_stats_from_constant

  validates :troop_type, presence: true

  TROOP_STATS = {
    swordsman: {
      1 => { attack: 10, defense: 15, speed: 1.2, cost: { wood: 20, stone: 10, metal: 50 } },
      2 => { attack: 14, defense: 21, speed: 1.3, cost: { wood: 28, stone: 14, metal: 70 } },
      3 => { attack: 20, defense: 30, speed: 1.4, cost: { wood: 40, stone: 20, metal: 100 } },
      4 => { attack: 28, defense: 42, speed: 1.5, cost: { wood: 56, stone: 28, metal: 140 } },
      5 => { attack: 40, defense: 60, speed: 1.6, cost: { wood: 80, stone: 40, metal: 200 } }
    },
    archer: {
      1 => { attack: 15, defense: 5,  speed: 0.9, cost: { wood: 50, stone: 10, metal: 20 } },
      2 => { attack: 21, defense: 7,  speed: 1.0, cost: { wood: 70, stone: 14, metal: 28 } },
      3 => { attack: 30, defense: 10, speed: 1.1, cost: { wood: 100, stone: 20, metal: 40 } },
      4 => { attack: 42, defense: 14, speed: 1.2, cost: { wood: 140, stone: 28, metal: 56 } },
      5 => { attack: 60, defense: 20, speed: 1.3, cost: { wood: 200, stone: 40, metal: 80 } }
    },
    cavalry: {
      1 => { attack: 20, defense: 10, speed: 0.6, cost: { wood: 80, stone: 60, metal: 30 } },
      2 => { attack: 28, defense: 14, speed: 0.7, cost: { wood: 112, stone: 84, metal: 42 } },
      3 => { attack: 40, defense: 20, speed: 0.8, cost: { wood: 160, stone: 120, metal: 60 } },
      4 => { attack: 56, defense: 28, speed: 0.9, cost: { wood: 224, stone: 168, metal: 84 } },
      5 => { attack: 80, defense: 40, speed: 1.0, cost: { wood: 320, stone: 240, metal: 120 } }
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

