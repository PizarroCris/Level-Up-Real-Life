class MapsController < ApplicationController
  before_action :authenticate_user!

  def index

    @profiles_with_castles = Profile.includes(:map_plot).where.not(map_plot: nil)
    
    @monsters = WorldMonster.all
    
    @available_plots = MapPlot.left_outer_joins(:profile).where(profiles: { id: nil })
  end
end
