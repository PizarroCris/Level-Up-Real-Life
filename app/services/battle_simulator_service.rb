class BattleSimulatorService
  def initialize(attacking_army, defender_profile)
    @attacking_army = attacking_army
    @defender_army = defender_profile.troops

    @attacker = attacking_army.first.profile
    @defender = defender_profile
    
    @battle_log = []
  end

  def call
    @battle_log << "A battle begins between #{@attacker.username} and #{@defender.username}!"

    while @attacking_army.reload.any? && @defender_army.reload.any?
      
      perform_attack_round(@attacking_army, @defender_army, @attacker, @defender)
      
      break if @defender_army.reload.empty?

      perform_attack_round(@defender_army, @attacking_army, @defender, @attacker)
    end

    determine_final_winner

    return { winner: @winner, log: @battle_log.join("\n") }
  end

  private

  def perform_attack_round(current_attacker_army, current_defender_army, attacker_profile, defender_profile)
    attack_power = current_attacker_army.sum(&:attack)
    defense_power = current_defender_army.sum(&:defense)
    damage = (attack_power - defense_power).max(0)
    
    losses = calculate_losses(current_defender_army, damage)

    @battle_log << "#{attacker_profile.username}'s army attacks with #{attack_power} power, dealing #{damage} damage!"
    @battle_log << "#{defender_profile.username}'s army suffers #{losses} casualties."

    current_defender_army.order(:level).limit(losses).destroy_all
  end

  def calculate_losses(army, total_damage)
    return 0 if army.empty?
    
    total_hp_of_army = army.sum(&:defense)
    average_hp_per_troop = total_hp_of_army.to_f / army.size
    return army.size if average_hp_per_troop.zero?
    
    number_of_losses = (total_damage / average_hp_per_troop).floor
    return number_of_losses.clamp(0, army.size)
  end

  def determine_final_winner
    if @attacking_army.reload.any?
      @winner = @attacker
      @battle_log << "#{@attacker.username} is victorious!"
    else
      @winner = @defender
      @battle_log << "#{@defender.username} is victorious!"
    end
  end
end
