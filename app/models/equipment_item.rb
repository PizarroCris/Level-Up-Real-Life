class EquipmentItem < ApplicationRecord
  VALID_TYPES = %w[helmet sword gauntlet armor boots accessory].freeze

  validates :equipment_type, inclusion: { in: VALID_TYPES }

  def image_path
    set_name = self.name.split.first.downcase + '_set'
    file_name = self.name.parameterize.underscore

    "equipments/#{set_name}/#{file_name}.png"
  end
end
