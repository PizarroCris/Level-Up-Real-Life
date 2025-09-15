class BattleSimulator
  def initialize(attacker_profile, defender_profile)
    @attacker = attacker_profile
    @defender = defender_profile
    @battle_log = []
  end

  def call
    while @attacker.can_fight? && @defender.can_fight?
      perform_attack_round(@attacker, @defender)
      break unless @defender.can_fight?
      perform_attack_round(@defender, @attacker)
    end

    if @attacker.can_fight?
      winner = @attacker
      @battle_log << "#{@attacker.username} is victorious!"
    else
      winner = @defender
      @battle_log << "#{@defender.username} is victorious!"
    end

    return { winner: winner, log: @battle_log.join("\n") }
  end

  private

  def perform_attack_round(current_attacker, current_defender)
    attack_power = current_attacker.total_attack
    defense_power = current_defender.total_defense

    damage = (attack_power - defense_power).max(0)

    losses = calculate_losses(current_defender.troops, damage)

    @battle_log << "#{current_attacker.username} attacks with #{attack_power} power against #{current_defender.username}'s #{defense_power} defense, dealing #{damage} damage!"
    @battle_log << "This results in #{losses} losses for #{current_defender.username}!"

    current_defender.troops.order(:level).limit(losses).destroy_all
  end

  def calculate_losses(army_troops, total_damage)
    return 0 if army_troops.empty?

    total_defense_points_of_army = army_troops.map(&:defense).sum
    average_defense_per_troop = total_defense_points_of_army.to_f / army_troops.size

    return army_troops.size if average_defense_per_troop.zero?
    
    number_of_losses = (total_damage / average_defense_per_troop).floor

    return number_of_losses.clamp(0, army_troops.size)
  end
end
