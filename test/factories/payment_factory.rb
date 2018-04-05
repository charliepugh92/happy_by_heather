FactoryBot.define do
  factory :payment do
    order
    amount { Faker::Number.decimal(1, 2) }
    confirmation_number { SecureRandom.uuid }
  end
end
