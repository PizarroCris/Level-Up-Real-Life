class BasesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.profile || current_user.create_profile(username: "user_#{current_user.id}")
    authorize @profile
    @plots = Plot.all
    @buildings_by_plot_id = @profile.buildings.includes(:plot).index_by(&:plot_id)
  end
end
