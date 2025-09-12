module BuildingsHelper
  def building_destination_path(building)
    case building.building_type.downcase
    when "barrack"
      building_troops_path(building)
    else
      building_path(building)
    end
  end
end
