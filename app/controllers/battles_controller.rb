class BattlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_battle, only: [:show]

  def index
    @battles = policy_scope(Battle).order(created_at: :desc)
  end

  def show
    authorize @battle
  end

  def new
    @attacker = current_user.profile
    @defender = Profile.find(params[:defender_id])
    @battle = Battle.new
    
    @attacker_troops_grouped = @attacker.troops.includes(:building).group_by { |troop| [troop.troop_type, troop.level] }
    @max_troops_per_attack = @attacker.max_troops_for_attack

    authorize @battle
  end

  def create
    @attacker = current_user.profile
    permitted_params = battle_params
    @defender = Profile.find(permitted_params[:defender_id])

    @battle = Battle.new(attacker: @attacker, defender: @defender)

    authorize @battle

    attacking_troops = []
    
    if permitted_params[:troops].present?
      permitted_params[:troops].each do |troop_key, quantity|
        troop_type, level = troop_key.split('_')
        
        troops_to_select = @attacker.troops.where(
          troop_type: troop_type, 
          level: level.to_i
        ).limit(quantity.to_i)
        
        attacking_troops.concat(troops_to_select)
      end
    end
    
    if attacking_troops.empty?
      redirect_to new_battle_path(defender_id: @defender.id), alert: "You must select troops to attack."
      return
    end

    simulator = BattleSimulatorService.new(attacking_troops, @defender)
    result = simulator.call

    @battle.winner = result[:winner]
    @battle.battle_log = result[:log]

    if @battle.save
      redirect_to @battle, notice: "Battle complete!"
    else
      @attacker_troops_grouped = @attacker.troops.group_by { |troop| [troop.troop_type, troop.level] }
      @max_troops_per_attack = @attacker.max_troops_for_attack
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_battle
    @battle = Battle.find(params[:id])
  end

  def battle_params
    params.require(:battle).permit(:defender_id, troops: {})
  end
end
