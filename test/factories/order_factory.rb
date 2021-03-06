FactoryBot.define do
  factory :order do
    delivery_type { Order.delivery_types[:ship_to_customer] }
    price { Faker::Number.decimal(3, 2) }
    customer
    order_info { Faker::Lorem.sentence }
    title { Faker::Lorem.words(3).join(' ').titleize }
  end
end
