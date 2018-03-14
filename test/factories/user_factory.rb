FactoryBot.define do
  require 'bcrypt'
  factory :user do
    transient do
      password 'password123'
    end

    sequence :username do |n|
      "User#{n}"
    end
    sequence :email do |n|
      "user_#{n}@example.com"
    end
    
    password_digest { BCrypt::Password.create(password) }
  end
end
