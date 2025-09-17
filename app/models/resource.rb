class Resource < ApplicationRecord
  belongs_to :building
  enum :kind, { metal: 0, wood: 1, stone: 2 }

  delegate :level, to: :building

  PRODUCTION_BY_LEVEL = {
    1 => 40, 2 => 120, 3 => 250, 4 => 420,
    5 => 630
  }.freeze

  STORAGE_BY_LEVEL = {
    1 => 2_100, 2 => 6_300, 3 => 12_600, 4 => 20_900,
    5 => 31_300
  }.freeze

  def production_per_hour
    PRODUCTION_BY_LEVEL[level] || 0
  end

  def storage_capacity
    STORAGE_BY_LEVEL[level] || 0
  end

  def levels_list
    (PRODUCTION_BY_LEVEL.keys | STORAGE_BY_LEVEL.keys).sort
  end

  def image_asset_path
    building_type = self.building.building_type.downcase
    folder = building_type.pluralize
    filename = "#{building_type}#{format('%02d', self.level)}.png"
    "buildings/#{folder}/#{filename}"
  end
end
