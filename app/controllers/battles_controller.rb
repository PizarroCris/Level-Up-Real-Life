class BattlesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_profile!
  before_action :set_battle, only: [:show]

  def show
    authorize @battle
  end

  def new
    @attacker = current_user.profile
    @defender = Profile.find(params[:defender_id])
    @battle = Battle.new
    @attacker_troops_grouped = @attacker.troops.group_by { |troop| [troop.troop_type, troop.level] }
    @max_troops_per_attack = @attacker.max_troops_for_attack
    authorize @battle
  end

  def create
    @attacker = current_user.profile
    @defender = Profile.find(battle_params[:defender_id])
    selected_troop_ids = battle_params[:troop_ids].flatten.reject(&:blank?)
    attacking_troops = @attacker.troops.where(id: selected_troop_ids)

    @battle = Battle.new(attacker: @attacker, defender: @defender)
    authorize @battle

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
    params.require(:battle).permit(:defender_id, troop_ids: [])
  end
end
