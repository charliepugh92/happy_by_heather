class CustomerAddress < ApplicationRecord
  belongs_to :customer

  validates :line_one, :city, :state, :zip_code, :customer, presence: true
end
