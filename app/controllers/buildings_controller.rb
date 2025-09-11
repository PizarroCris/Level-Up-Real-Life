class BuildingsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_profile!

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
      redirect_to user_base_path, notice: "#{@building.building_type.capitalize} successfully built!"
    else
      @plot = Plot.find(building_params[:plot_id])
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @building = Building.find(params[:id])
    authorize @building
  end

  def edit
  end

  def update
  end

  private

  def ensure_profile!
    return if current_user.profile.present?
    current_user.create_profile!(username: current_user.email.split("@").first)
  end

  def building_params
    params.require(:building).permit(:building_type, :plot_id)
  end
end
