module BuildingsHelper
  def building_destination_path(building)
    kind = building.building_type.downcase
    resource_types = ["mine", "sawmill", "quarry"]

    if resource_types.include?(kind)
      send("building_#{kind}_path", building)
    
    elsif kind == "barrack"
      building_troops_path(building)
      
    else
      building_path(building)
    end
  end
end
