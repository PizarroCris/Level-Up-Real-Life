class ResourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_building
  before_action :set_resource, only: [:show]

  def show
    authorize @resource
  end

  private

  def set_building
    @building = Building.find(params[:building_id])
  end

  def set_resource
    building_type = params[:kind]
    resource_kind = Building::BUILDING_TO_RESOURCE_MAP[building_type]
    @resource = @building.resources.find_by!(kind: resource_kind)
  end
end
