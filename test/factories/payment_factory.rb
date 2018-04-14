FactoryBot.define do
  factory :payment do
    order
    amount { Faker::Number.decimal(1, 2) }
    payment_type { Payment.payment_types[:paypal] }
    confirmation_number { SecureRandom.uuid }
  end
end
