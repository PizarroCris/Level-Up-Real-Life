class TroopsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_profile!

  skip_after_action :verify_authorized, only: [:index, :new, :create]
  skip_after_action :verify_policy_scoped, only: [:index]

  def index
    @troops = current_user.profile.troops.order(created_at: :desc)
  end

  def new
    @building = Building.find(params[:building_id])
    @troop = @building.troops.new
  end

  def create
    @building = Building.find(params[:building_id])
    @troop = @building.troops.new(troop_params.merge(level: 1))
    if @troop.save
      redirect_to building_troops_path(@building)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def ensure_profile!
    return if current_user.profile.present?
    current_user.create_profile!(username: current_user.email.split("@").first)
  end

  def troop_params
    params.require(:troop).permit(:troop_type)
  end
end
