class Guild < ApplicationRecord
  belongs_to :leader, class_name: 'Profile'
  has_many :guild_memberships
  has_many :profiles, through: :guild_memberships

  validates :name,
          presence: true,
          uniqueness: { case_sensitive: false },
          length: { in: 4..20 }
  validates :tag, 
          presence: true, 
          uniqueness: { case_sensitive: false },
          length: { in: 3..5 },
          format: { with: /\A[A-Z0-9]+\z/, message: "can only contain uppercase letters and numbers" }
end
