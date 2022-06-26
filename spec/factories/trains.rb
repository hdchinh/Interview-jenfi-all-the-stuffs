FactoryBot.define do
  factory :train do
    max_weight { 100 }
    max_volume { 3 }
    cost { 100 }
    train_operator
    lines { %w[A B] }
  end
end
