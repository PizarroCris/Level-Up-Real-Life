class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  
  after_create :create_user_profile

private

  def create_user_profile
    empty_spot = MapPlot.where.missing(:profile).first
    central_plot = Plot.find_by(name: "Plot 1") || Plot.first
    base_username = self.email.split('@').first.gsub(/[^a-zA-Z0-9]/, '')
    unique_username = "#{base_username}-#{self.id}"

    profile = self.create_profile!(
      username: unique_username,
      map_plot: empty_spot
    )

    if profile && central_plot
      profile.buildings.create!(
        plot: central_plot,
        building_type: 'castle',
        level: 1
      )
    end
  end
end
