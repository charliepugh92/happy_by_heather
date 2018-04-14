class Payment < ApplicationRecord
  belongs_to :order

  validates :amount, :order, :payment_type, presence: true

  enum payment_type: %i[cash paypal]
end
