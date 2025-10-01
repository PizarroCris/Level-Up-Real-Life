FactoryBot.define do
  factory :map_plot do
    pos_x { rand(0..100) }
    pos_y { rand(0..100) }
  end

  trait :with_profile do
    association :profile
  end
end
