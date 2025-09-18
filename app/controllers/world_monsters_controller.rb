class WorldMonstersController < ApplicationController
  before_action :authenticate_user!

  def attack
    @monster = WorldMonster.find(params[:id])
    authorize @monster

    @monster.hp -= 10

    if @monster.hp <= 0
      @monster.destroy
      flash.now[:notice] = "You defeated the #{@monster.name}!"
    else
      @monster.save
      flash.now[:notice] = "You attacked the #{@monster.name}! It has #{@monster.hp} HP left."
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

   def show
    @monster = WorldMonster.find(params[:id])
    authorize @monster

    render json: {
      id: @monster.id,
      name: @monster.name,
      level: @monster.level,
      hp: @monster.hp,
      attack_url: attack_world_monster_path(@monster)
    }
  end
end
