FactoryBot.define do
  factory :equipment_item do
    sequence(:name) { |n| "Sword of Testing #{n}" }
    equipment_type { "sword" }
    attack { 10 }
    defense { 5 }
    speed_bonus { 0 }
    price_in_steps { 100 }
  end
end
