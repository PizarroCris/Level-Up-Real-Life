class BattleSimulatorService
  def initialize(attacking_army, defender_profile)
    @attacking_army = attacking_army.to_a
    @defender_army = defender_profile.troops.to_a

    @attacker = attacking_army.first.profile
    @defender = defender_profile

    @battle_log = []
  end

  def call
    @battle_log << "Rivalry erupts! The army of **#{@attacker.username}** marches against **#{@defender.username}'s** defenses!"

    round_number = 1
    while @attacking_army.any? && @defender_army.any?
      @battle_log << "\n--- Round ##{round_number} ---"

      perform_attack_round(@attacking_army, @defender_army, @attacker, @defender)
      sleep(0.01)
      
      @defender_army = @defender_army.select(&:persisted?)

      @battle_log << "**#{@attacker.username}'s** vanguard strikes with a combined power of **#{attack_power_attacker}**! **#{@defender.username}'s** defenses are overwhelmed, suffering **#{losses_defender} casualties**!"

      break if @defender_army.empty?

      perform_attack_round(@defender_army, @attacking_army, @defender, @attacker)

      @battle_log << "In response, **#{@defender.username}'s** troops counter-attack with cunning, inflicting **#{damage_to_attacker}** damage and eliminating **#{losses_attacker} soldiers** from the attacking army!"
      sleep(0.01)

      @attacking_army = @attacking_army.select(&:persisted?)

      round_number += 1
    end

    determine_final_winner

    @battle_log << "\n--- End of Battle ---"
    @battle_log << "The battlefield is now silent. Victor: **#{@winner.username}**!"

    return { winner: @winner, log: @battle_log.join("\n") }
  end

  private

  def perform_attack_round(current_attacker_army, current_defender_army, attacker_profile, defender_profile)
    attack_power = current_attacker_army.sum(&:attack)
    defense_power = current_defender_army.sum(&:defense)
    damage = [attack_power - defense_power, 0].max

    losses = calculate_losses(current_defender_army, damage)

    @battle_log << "#{attacker_profile.username}'s army attacks with #{attack_power} power, dealing #{damage} damage!"
    @battle_log << "#{defender_profile.username}'s army suffers #{losses} casualties."

    troops_to_destroy = current_defender_army.sort_by(&:level).first(losses)
    troops_to_destroy.each(&:destroy)
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
    if @attacking_army.any?
      @winner = @attacker
      @battle_log << "#{@attacker.username} is victorious!"
    else
      @winner = @defender
      @battle_log << "#{@defender.username} is victorious!"
    end
  end
end
