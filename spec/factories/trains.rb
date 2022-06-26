FactoryBot.define do
  factory :train do
    max_weight { 1 }
    max_volume { 1 }
    train_operator { nil }
  end
end
