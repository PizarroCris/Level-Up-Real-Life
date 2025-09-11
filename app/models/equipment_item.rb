class EquipmentItem < ApplicationRecord
  VALID_TYPES = %w[helmet sword gauntlet armor boots accessory].freeze

  validates :equipment_type, inclusion: { in: VALID_TYPES }
end
