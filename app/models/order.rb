class Order < ApplicationRecord
  belongs_to :customer
  has_many :payments, dependent: :destroy

  validates :price, :order_info, :title, :delivery_type, :customer, presence: true

  enum status: %i[not_started in_progress shipped complete]
  enum delivery_type: %i[ship_to_customer pick_up]

  def remaining_balance
    running_total = price
    payments.each { |p| running_total -= p.amount }
    running_total
  end

  private

  def send_confirmation_email
    # TODO: OrderMailer.confirmation(id).send_later
  end
end
