FactoryBot.define do
  factory :plot do
    sequence(:name) { |n| "Plot #{n}" }
    pos_x { rand(0..100) }
    pos_y { rand(0..100) }
  end
end
