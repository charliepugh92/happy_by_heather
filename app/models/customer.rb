class Customer < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_one :customer_address, dependent: :destroy

  validates :first_name, :last_name, :email, :phone_number, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
