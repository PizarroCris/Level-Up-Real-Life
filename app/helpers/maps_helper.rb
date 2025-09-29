module MapsHelper
  def castle_interaction_options(castle_owner_profile)
    buttons = []

    if castle_owner_profile == current_user.profile
      buttons << { text: "Go to Base", path: root_path, class: "btn-red" }
    elsif current_user.profile.guild.present? && castle_owner_profile.guild == current_user.profile.guild
      buttons << { text: "Send Help", path: "#", class: "btn-red" }
    else
      buttons << { 
        text: "Attack", 
        path: battles_path,
        class: "btn-red",
        method: "post",
        defender_id: castle_owner_profile.id
      }
    end

    return {
      title: castle_owner_profile.username,
      details: "Guild: #{castle_owner_profile.guild&.name || 'None'}",
      buttons: buttons
    }
  end

  def monster_interaction_options(monster)
    attack_cost = 10
    can_afford = current_user.profile.current_energy >= attack_cost
    {
      title: "#{monster.name} (Lvl #{monster.level})",
      details: "HP: #{monster.hp}",
      buttons: [
        {
          text: "Attack (Cost: #{attack_cost} Energy)",
          path: attack_world_monster_path(monster),
          class: "btn-red",
          method: "post",
          disabled: !can_afford 
        }
      ]
    }
  end
end
