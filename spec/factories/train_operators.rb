FactoryBot.define do
  factory :train_operator do
    name { Faker::Name.unique.name }
    total_trains { 0 }
  end
end
