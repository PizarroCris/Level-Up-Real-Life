class BuildingsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_profile!
  before_action :set_building, only: [:show, :upgrade, :collect_resources]

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
      redirect_to user_base_path, notice: "#{@building.building_type.capitalize} Success!"
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

  def collect_resources
    authorize @building
    resource = @building.resources.first
    unless resource
      return redirect_to building_path(@building), alert: "Este edifício não produz recursos."
    end
    collected_amount = resource.quantity
    if collected_amount > 0
      ActiveRecord::Base.transaction do
        profile = current_user.profile
        profile.increment!(resource.kind, collected_amount)
        resource.update!(quantity: 0, last_collected_at: Time.now)
      end
      redirect_to root_path, notice: "Você coletou #{collected_amount} de #{resource.kind}."
    else
      redirect_to root_path, alert: "Nenhum recurso para coletar."
    end
  end

  private

  def set_building
    @building = Building.find(params[:id])
  end

  def building_params
    params.require(:building).permit(:building_type, :plot_id)
  end
end
