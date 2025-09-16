class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  after_create :create_user_profile

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def create_user_profile
    self.create_profile!(username: self.email.split('@').first)
  end
end
