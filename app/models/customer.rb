class Customer < ApplicationRecord
  has_many :orders
  has_one :customer_address
end
