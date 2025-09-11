class Building < ApplicationRecord
  belongs_to :profile
  belongs_to :plot
  has_many :troops, dependent: :destroy

  BUILDING_TYPES = %w[castle barrack quarry sawmill mine]

  validates :building_type, presence: true, inclusion: { in: BUILDING_TYPES }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, allow_nil: true

  validates :building_type, uniqueness: { scope: :profile_id, message: "already exists" }

  def folder_name
    building_type.pluralize
  end
end
