module BuildingsHelper
  def building_interaction_options(building)
    upgrade_text = next_upgrade_text(building)
    building_type_plural = building.building_type.downcase.pluralize
    building_type_singular = building.building_type.downcase.singularize
    level_formatted = format('%02d', building.level)
    image_path = asset_path("buildings/#{building_type_plural}/#{building_type_singular}#{level_formatted}.png")
    {
      title: building.building_type.titleize,
      details: "Nível #{building.level}",
      image_url: image_path,
      upgrade_cost_html: upgrade_text,
      buttons: [
        {
          text: "Upgrade",
          path: upgrade_building_path(building),
          class: "btn-primary",
          method: "patch",
          disabled: building.max_level?
        },
        {
          text: "Info",
          path: building_destination_path(building),
          class: "btn-secondary",
          method: "get"
        }
      ]
    }
  end

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
