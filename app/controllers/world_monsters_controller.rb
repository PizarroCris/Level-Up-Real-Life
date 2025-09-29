class WorldMonstersController < ApplicationController
  before_action :authenticate_user!

  def attack
    @monster = WorldMonster.find(params[:id])
    authorize @monster

    attack_cost = 10

    if current_user.profile.spend_energy(attack_cost)
      @rewards = current_user.profile.gain_rewards_from_monster(@monster)
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

    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend("notifications", partial: "shared/alert", locals: { alert: "Not enough energy!" })
        end
        format.html { redirect_to world_map_path, alert: "Not enough energy!" }
      end
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
