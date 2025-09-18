class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  
  after_create :create_user_profile

  private

  def create_user_profile
    empty_spot = MapPlot.where.missing(:profile).first
    
    if empty_spot
      self.create_profile!(
        username: self.email.split('@').first,
        map_plot: empty_spot
      )
    else
      raise "No available map plots to create a user profile."
    end
  end
end
