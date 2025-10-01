FactoryBot.define do
  factory :profile do
    association :user
    sequence(:username) { |n| "Player#{n}" }
    attack { 100 }
    defense { 100 }
    steps { 0 }
    wood { 500 }
    stone { 500 }
    metal { 500 }
    level { 1 }
    experience { 0 }
    speed_bonus { 0 }
    current_energy { 100 }
    max_energy { 100 }
    energy_last_updated_at { Time.current }
    association :map_plot
  end
end
