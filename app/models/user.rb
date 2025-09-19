class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  
  after_create :create_user_profile

  private

  def create_user_profile
    empty_spot = MapPlot.where.missing(:profile).first

    new_profile = self.create_profile!(
      username: self.email.split('@').first,
      map_plot: empty_spot
    )

    central_plot = Plot.find_by(name: "Plot 1") || Plot.first

    if central_plot && new_profile
      Building.create!(
        profile: new_profile,
        plot: central_plot,
        building_type: 'castle',
        level: 1
      )
    end
  end
end
