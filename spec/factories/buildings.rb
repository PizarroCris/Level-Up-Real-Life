FactoryBot.define do
  factory :building do
    building_type { "castle" }
    level { 1 }
    association :profile
    association :plot
  end
end
