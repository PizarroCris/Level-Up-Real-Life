class Resource < ApplicationRecord
  belongs_to :building
  enum :kind, { mine: 0, sawmill: 1, quarry: 2 }

  # Same numbers for all kinds (you can change later per kind if needed)
  PRODUCTION_BY_LEVEL = {
    1 => 40,   2 => 120,  3 => 250,  4 => 420,
    5 => 630
  }.freeze

  STORAGE_BY_LEVEL = {
    1 => 2_100, 2 => 6_300, 3 => 12_600, 4 => 20_900,
    5 => 31_300
  }.freeze

  def production_per_hour
    PRODUCTION_BY_LEVEL[level] || PRODUCTION_BY_LEVEL.values.last
  end

  def storage_capacity
    STORAGE_BY_LEVEL[level] || STORAGE_BY_LEVEL.values.last
  end

  # Helper for the view
  def levels_list
    (PRODUCTION_BY_LEVEL.keys | STORAGE_BY_LEVEL.keys).sort
  end
end
