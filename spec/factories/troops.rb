FactoryBot.define do
  factory :troop do
    troop_type { "swordsman" }
    level { 1 }
    attack { 10 }
    defense { 10 }
    speed { 5 }

    association :building
  end
end
