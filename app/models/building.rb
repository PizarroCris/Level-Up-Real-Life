class Building < ApplicationRecord
  belongs_to :profile
  has_many :troops, dependent: :destroy

  BUILDING_TYPES = %w[castle barracks quarry sawmill mine]
end
