class BuildingsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_profile!

  skip_after_action :verify_authorized,    only: [:index, :new, :create]
  skip_after_action :verify_policy_scoped, only: [:index]

  def index
    @buildings = current_user.profile.buildings.order(created_at: :desc)
  end

  def new
    @building = Building.new
  end

  def create
    @building = current_user.profile.buildings.new(building_params.merge(level: 1))
    if @building.save
      redirect_to buildings_path, notice: "Building created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def ensure_profile!
    return if current_user.profile.present?
    current_user.create_profile!(username: current_user.email.split("@").first)
  end

  def building_params
    params.require(:building).permit(:building_type)
  end
end
