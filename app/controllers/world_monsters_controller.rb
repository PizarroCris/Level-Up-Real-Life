class WorldMonstersController < ApplicationController
  before_action :authenticate_user!

  def attack
    @monster = WorldMonster.find(params[:id])
    
    current_user.profile.gain_rewards(monster_level: @monster.level)

    @monster.receive_attack(10)
    
    if @monster.dead?
      flash[:notice] = "You defeated the #{@monster.name}! It will respawn elsewhere."
    else
      flash[:notice] = "You attacked the #{@monster.name}! It has #{@monster.hp} HP left."
    end
    
    redirect_to world_map_path
  end
end
