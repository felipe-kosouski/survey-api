FactoryBot.define do
  factory :option do
    title { Faker::Lorem.sentence }
    voteQt { Faker::Number.number(2) }
  end
end