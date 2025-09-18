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
  def next_upgrade_text(building)
    return "Max level reached" if building.max_level?

    cost = building.upgrade_cost
    return "Upgrade: No cost" if cost.blank?

    parts = cost.map { |res, amt| "#{res.to_s.capitalize}:&nbsp;#{amt}" }.join("<br>")
    "Upgrade:<br>#{parts}".html_safe
  end
end
