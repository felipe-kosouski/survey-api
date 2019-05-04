FactoryBot.define do
  factory :survey do
    title { Faker::Lorem.sentence }
    startDate { Faker::Date.between(5.days.ago, Date.today) }
    endDate { Faker::Date.forward(25) }
    status { Faker::Number.between(0, 2) }
    totalVotes { Faker::Number.number(3) }
  end
end