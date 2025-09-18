class WorldMonstersController < ApplicationController
  before_action :authenticate_user!

  def attack
  @monster = WorldMonster.find(params[:id])
  authorize @monster

  attack_cost = 10 

  if current_user.profile.energy < attack_cost
    redirect_to world_map_path, alert: "Not enough energy to attack!"
    return
  end

  current_user.profile.decrement!(:energy, attack_cost)
    @rewards = current_user.profile.gain_rewards_from_monster(@monster)

    @monster.hp -= 10

    if @monster.hp <= 0
      @monster.destroy
      flash.now[:notice] = "You defeated the #{@monster.name}!"
    else
      @monster.save
      flash.now[:notice] = "You attacked the #{@monster.name}! It has #{@monster.hp} left."
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.prepend("flashes", partial: "shared/flashes"),
          turbo_stream.update("energy-bar-container", partial: "shared/energy_bar"),
          turbo_stream.append("map-ui-wrapper", partial: "maps/rewards_popup", locals: { monster: @monster, rewards: @rewards })
        ]
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
