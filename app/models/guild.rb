class Guild < ApplicationRecord
  belongs_to :leader, class_name: 'Profile'
  has_many :guild_memberships
  has_many :profiles, through: :guild_memberships

  before_validation :set_default_max_members, on: :create

  validates :name,
          presence: true,
          uniqueness: { case_sensitive: false },
          length: { in: 4..20 }
  validates :tag, 
          presence: true, 
          uniqueness: { case_sensitive: false },
          length: { in: 3..5 },
          format: { with: /\A[A-Z0-9]+\z/, message: "can only contain uppercase letters and numbers" }
  validates :max_members, presence: true, numericality: { greater_than_or_equal_to: 1 }

  def full?
    profiles.count >= max_members
  end

  private

  def set_default_max_members
    self.max_members = 50 if max_members.nil?
  end
end
