module MapsHelper
  def castle_interaction_options(castle_owner_profile)
    options = []

    if castle_owner_profile == current_user.profile
      options << { text: "Go to Base", path: root_path, class: "btn-primary" }
    elsif current_user.profile.guild.present? && castle_owner_profile.guild == current_user.profile.guild
      options << { text: "Send Help", path: "#", class: "btn-success" }
    else
      options << { text: "Attack", path: new_battle_path(defender_id: castle_owner_profile.id), class: "btn-danger" }
    end
    return options
  end
end
