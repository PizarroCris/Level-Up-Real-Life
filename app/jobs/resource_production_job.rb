class ResourceProductionJob < ApplicationJob
  queue_as :default

  def perform
    Building.where(building_type: Building::BUILDING_TO_RESOURCE_MAP.keys).each do |building|
      resource = building.resources.first
      if resource
        production_per_minute = resource.production_per_hour / 60.0
        new_quantity = [resource.quantity + production_per_minute.round, resource.storage_capacity].min
        resource.update!(quantity: new_quantity)
      end
    end
  end
end
