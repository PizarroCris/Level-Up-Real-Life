class BuildingsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_profile!
  before_action :set_building, only: [:show, :upgrade]

  def new
    @plot = Plot.find(params[:plot_id])
    @building = Building.new(plot: @plot)
    authorize @building
  end

  def create
    @building = Building.new(building_params)
    @building.profile = current_user.profile
    @building.level = 1
    authorize @building

    if @building.save
      redirect_to user_base_path, notice: "#{@building.building_type.capitalize} foi construído com sucesso!"
    else
      @plot = @building.plot
      render :new, status: :unprocessable_entity
    end
  end

  def show
    authorize @building
  end
  
  def upgrade
    authorize @building

    profile = current_user.profile
    cost = @building.upgrade_cost

    if profile.can_afford?(cost)
      ActiveRecord::Base.transaction do
        profile.deduct_resources!(cost)
        @building.update!(level: @building.level + 1)
      end

      flash[:notice] = "#{@building.building_type.capitalize} was updated to level #{@building.level}!"
    else
      flash[:alert] = "You don't have enough resources to upgrade."
    end
    case params[:return]
    when "sawmill" then redirect_to building_sawmill_path(@building)
    when "mine" then redirect_to building_mine_path(@building)
    when "quarry" then redirect_to building_quarry_path(@building)
    else
      redirect_to root_path
    end
  end

  private

  def set_building
    @building = Building.find(params[:id])
  end

  def ensure_profile!
    return if current_user.profile.present?
    current_user.create_profile!(username: current_user.email.split("@").first)
  end

  def building_params
    params.require(:building).permit(:building_type, :plot_id)
  end
end
