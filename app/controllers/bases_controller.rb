class BasesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_profile!

  def show
    @profile = current_user.profile
    authorize @profile
    @profile.update_resources_from_buildings

    @plots = Plot.all
    @buildings_by_plot_id = current_user.profile.buildings.includes(:plot, :resources).index_by(&:plot_id)
    @guild = current_user.profile.guild
    @equipments = EquipmentItem.all
  end

  private

  def ensure_profile!
    @profile = current_user.profile || current_user.create_profile(username: "user_#{current_user.id}")
  end
end
