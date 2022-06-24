FactoryBot.define do
  factory :line do
    name { Faker::Name.initials }
    blocked { false }
  end
end
