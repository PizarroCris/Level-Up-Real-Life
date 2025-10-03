module ApplicationHelper
  def seconds_until_next_energy(profile)
    return 72 if profile.energy_last_updated_at.nil?

    return 0 if profile.current_energy >= profile.max_energy

    seconds_per_point = 72
    time_passed = Time.current - profile.energy_last_updated_at

    seconds_into_current_cycle = time_passed % seconds_per_point
    (seconds_per_point - seconds_into_current_cycle).ceil
  end
end
