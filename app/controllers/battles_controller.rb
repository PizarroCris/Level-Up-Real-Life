class BattlesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_profile!
  before_action :set_battle, only: [:show]

  def show
    authorize @battle
  end

  def new
    @attacker = current_user.profile
    @attacker_troops_eager_loaded = @attacker.troops.includes(:building)

    @defender = Profile.includes(:troops).find(params[:defender_id])
    
    @battle = Battle.new
    @attacker_troops_grouped = @attacker_troops_eager_loaded.group_by { |troop| [troop.troop_type, troop.level] }
    
    @max_troops_per_attack = @attacker.max_troops_for_attack

    authorize @battle
  end

  def create
    @attacker = current_user.profile
    @defender = Profile.find(params[:battle][:defender_id])
    @battle = Battle.new(attacker: @attacker, defender: @defender)
    authorize @battle

    attacking_army = []
    troop_quantities = battle_params[:troops] || {}

    troop_quantities.each do |type_and_level, quantity_str|
      quantity = quantity_str.to_i
      next if quantity.zero?

      type, level = type_and_level.split('_')
      troops_to_send = @attacker.troops.where(troop_type: type, level: level).limit(quantity)
      attacking_army.concat(troops_to_send)
    end

    if attacking_army.empty?
      redirect_to new_battle_path(defender_id: @defender.id), alert: "You must select troops to attack."
      return
    end

    simulator = BattleSimulatorService.new(attacking_army, @defender)
    result = simulator.call

    @battle.winner = result[:winner]
    @battle.battle_log = result[:log]

    respond_to do |format|
      if @battle.save
        format.turbo_stream { redirect_to @battle }
        format.html { redirect_to @battle, notice: "Battle complete!" }
      else
        @attacker_troops_grouped = @attacker.unlocked_troops.group_by { |troop| [troop.troop_type, troop.level] }
        @max_troops_per_attack = @attacker.max_troops_for_attack
        format.html { render :new, status: :unprocessable_entity }
      end
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
