class Building < ApplicationRecord
  belongs_to :profile
  belongs_to :plot
  has_many :troops, dependent: :destroy
  has_many :resources, dependent: :destroy

  BUILDING_TO_RESOURCE_MAP = {
    "mine"    => :metal,
    "sawmill" => :wood,
    "quarry"  => :stone
  }.freeze

  after_create :create_resource_if_needed

  CASTLE_MAX_LEVEL = 5
  CASTLE_ATTACK_BY_LEVEL  = { 1=>100, 2=>200, 3=>300, 4=>400, 5=>500 }.freeze
  CASTLE_DEFENSE_BY_LEVEL = { 1=>100, 2=>200, 3=>300, 4=>400, 5=>500 }.freeze

  MAX_LEVEL = 5

  BUILDING_STATS = {
 'castle' => {
      1 => { cost: { wood: 100, stone: 80, metal: 50 }, max_troops_for_attack: 250 },
      2 => { cost: { wood: 250, stone: 200, metal: 120 }, max_troops_for_attack: 500 },
      3 => { cost: { wood: 600, stone: 550, metal: 300 }, max_troops_for_attack: 1000 },
      4 => { cost: { wood: 1500, stone: 1200, metal: 750 }, max_troops_for_attack: 2500 },
      5 => { cost: {}, max_troops_for_attack: 5000 }
    },
    'sawmill' => {
      creation_cost: { wood: 0, stone: 40, metal: 10 },
      1 => { cost: { wood: 0, stone: 80, metal: 25 } },
      2 => { cost: { wood: 0, stone: 180, metal: 60 } },
      3 => { cost: { wood: 0, stone: 400, metal: 150 } },
      4 => { cost: { wood: 0, stone: 900, metal: 350 } },
      5 => { cost: {} }
    },
    'quarry' => {
      creation_cost: { wood: 50, stone: 0, metal: 20 },
      1 => { cost: { wood: 100, stone: 0, metal: 40 } },
      2 => { cost: { wood: 220, stone: 0, metal: 90 } },
      3 => { cost: { wood: 500, stone: 0, metal: 200 } },
      4 => { cost: { wood: 1100, stone: 0, metal: 450 } },
      5 => { cost: {} }
    },
    'mine' => {
      creation_cost: { wood: 60, stone: 60, metal: 0 },
      1 => { cost: { wood: 120, stone: 120, metal: 0 } },
      2 => { cost: { wood: 280, stone: 280, metal: 0 } },
      3 => { cost: { wood: 600, stone: 600, metal: 0 } },
      4 => { cost: { wood: 1400, stone: 1400, metal: 0 } },
      5 => { cost: {} }
    },
    'barrack' => {
      creation_cost: { wood: 100, stone: 80, metal: 40 },
      1 => { cost: { wood: 200, stone: 160, metal: 80 } },
      2 => { cost: { wood: 450, stone: 350, metal: 180 } },
      3 => { cost: { wood: 900, stone: 700, metal: 400 } },
      4 => { cost: { wood: 2000, stone: 1600, metal: 900 } },
      5 => { cost: {} }
    }
  }.freeze

  BUILDING_TYPES = BUILDING_STATS.keys.freeze

  validates :building_type, presence: true, inclusion: { in: BUILDING_TYPES }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :building_type, uniqueness: { scope: :profile_id, message: "already exists" }

  def image_asset_path
    folder = self.building_type.pluralize.downcase
    filename = "#{self.building_type.downcase}#{format('%02d', self.level)}.png"
    "buildings/#{folder}/#{filename}"
  end

  def upgrade_cost
    return {} if max_level?
    BUILDING_STATS.dig(self.building_type, self.level, :cost) || {}
  end

  def max_level?
    self.level >= MAX_LEVEL
  end

  def level_up!
    self.increment!(:level) unless max_level?
  end

  def self.creation_cost_for(building_type)
    BUILDING_STATS.dig(building_type, :creation_cost)
  end

  def can_upgrade?
    profile = self.profile
    castle = profile.buildings.find_by(building_type: 'castle')
    if self.building_type != 'castle' && self.level >= castle.level
      self.errors.add(:base, "The building's level cannot be higher than the castle's level.")
      return false
    end
    if self.building_type == 'barrack'
      other_buildings = profile.buildings.where.not(building_type: ['barrack', 'castle'])
      unless other_buildings.all? { |b| b.level >= castle.level }
        self.errors.add(:base, "All other buildings must be at the same level as the castle to upgrade the Barrack.")
        return false
      end
    end
    return true
  end

  private

  def create_resource_if_needed
    building_kind_string = self.building_type.downcase
    if BUILDING_TO_RESOURCE_MAP.key?(building_kind_string)
      resource_kind = BUILDING_TO_RESOURCE_MAP[building_kind_string]
      self.resources.create!(kind: resource_kind)
    end
  end
end
