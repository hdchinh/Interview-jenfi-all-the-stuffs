FactoryBot.define do
  factory :package do
    customer
    status { 0 }
    weight { 1 }
    volume { 1 }
  end
end
