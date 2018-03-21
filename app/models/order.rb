class Order < ApplicationRecord
  belongs_to :customer
  has_many :payments

  enum status: [:not_started, :in_progress, :shipped, :complete]
  enum payment_type: [:cash, :paypal]
  enum delivery_type: [:ship_to_customer, :pick_up]

  def remaining_balance
    running_total = price
    payments.each { |p| running_total -= p.amount }
    running_total
  end
end
