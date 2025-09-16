class MapsController < ApplicationController
  before_action :authenticate_user!

  def index
    @profiles_with_castles = policy_scope(Profile).includes(:map_plot, :buildings)
    @monsters = policy_scope(WorldMonster)
    @available_plots = policy_scope(MapPlot).left_outer_joins(:profile).where(profiles: { id: nil })
  end
end
