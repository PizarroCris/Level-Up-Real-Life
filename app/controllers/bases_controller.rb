class BasesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.profile
    authorize @profile
    @plots = Plot.all
    @buildings_by_plot_id = @profile.buildings.includes(:plot).index_by(&:plot_id)
  end
end
