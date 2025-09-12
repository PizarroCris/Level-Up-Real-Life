class ResourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_building
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def index
  @resources = policy_scope(Resource)
               .where(building_id: @building.id)
  @resources = @resources.where(kind: params[:kind]) if params[:kind].present?
  end

  def show
    authorize @resource
  end

  def new
    @resource = @building.resources.new
    authorize @resource
  end

  def create
    @resource = @building.resources.new(resource_params)
    authorize @resource
    if @resource.save
      redirect_to building_resources_path(@building), notice: "Resource created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @resource
  end

  def update
    authorize @resource
    if @resource.update(resource_params)
      redirect_to building_resources_path(@building), notice: "Resource updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @resource
    @resource.destroy
    redirect_to building_resources_path(@building), notice: "Resource deleted."
  end

  private

  def set_building
    @building = Building.find(params[:building_id])
  end

  def set_resource
    @resource = @building.resources.find(params[:id])
  end

  def resource_params
    params.require(:resource).permit(:kind, :level)
  end
end
