class Customer < ApplicationRecord
  has_many :orders
  has_one :customer_address

  validates :first_name, :last_name, :email, :phone_number, presence: true
end
