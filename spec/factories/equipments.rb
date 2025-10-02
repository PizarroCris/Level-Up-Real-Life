FactoryBot.define do
  factory :equipment do
    association :profile
    association :equipment_item
  end
end
