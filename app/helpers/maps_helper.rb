module MapsHelper
  def castle_interaction_options(castle_owner_profile)
    buttons = []

    if castle_owner_profile == current_user.profile
      buttons << { text: "Go to Base", path: root_path, class: "btn-red" }
    elsif current_user.profile.guild.present? && castle_owner_profile.guild == current_user.profile.guild
      buttons << { text: "Send Help", path: "#", class: "btn-red" }
    else
      buttons << { text: "Attack", path: new_battle_path(defender_id: castle_owner_profile.id), class: "btn-red" }
    end

    return {
      title: castle_owner_profile.username,
      details: "Guild: #{castle_owner_profile.guild&.name || 'None'}",
      buttons: buttons
    }
  end
end
