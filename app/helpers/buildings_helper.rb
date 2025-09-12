module BuildingsHelper
  def building_destination_path(building)
    case building.building_type.downcase
    when "barrack"
      building_troops_path(building)

    when "mine", "sawmill", "quarry"
      kind = building.building_type.downcase
      resource = building.resources.find_by(kind: kind)

      if resource
        building_resource_path(building, resource)
      else
        new_building_resource_path(building, resource: { kind: kind })
      end

    else
      building_path(building)
    end
  end
end
