class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  
  after_create :create_user_profile

private

  def create_user_profile
  unless self.profile.present?
    empty_spot = MapPlot.where.missing(:profile).first
    
    self.create_profile!(
      username: "#{self.email.split('@').first.gsub(/[^a-zA-Z0-9]/, '')}-#{self.id}",
      map_plot: empty_spot
    )
    self.reload
  end

  if self.profile.buildings.where(building_type: 'castle').empty?
    central_plot = Plot.find_by(name: "Plot 1") || Plot.first
    if central_plot
      self.profile.buildings.create!(
        plot: central_plot,
        building_type: 'castle',
        level: 1
      )
    end
  end
  end
end
