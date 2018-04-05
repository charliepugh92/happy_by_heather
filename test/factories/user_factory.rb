FactoryBot.define do
  require 'bcrypt'
  factory :user do
    transient do
      password { Faker::Internet.password }
    end

    username { Faker::Internet.user_name }
    email { Faker::Internet.email }

    password_digest { BCrypt::Password.create(password) }
  end
end
