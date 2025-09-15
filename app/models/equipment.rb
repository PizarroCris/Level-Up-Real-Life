class Equipment < ApplicationRecord
  belongs_to :profile
  belongs_to :equipment_item

  delegate :name, :equipment_type, :attack, :defense, :speed_bonus, to: :equipment_item
end
