FactoryBot.define do
  factory :customer_address do
    customer

    line_one { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip_code { Faker::Address.zip_code }

    trait :with_country do
      country { Faker::Address.country }
    end

    trait :with_line_two do
      line_two { Faker::Address.secondary_address }
    end
  end
end
