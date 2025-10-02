FactoryBot.define do
  factory :building do
    building_type { "castle" }
    level { 1 }
    association :profile
    association :plot

    trait :barrack do
      building_type { "barrack" }
    end
  end
end
