class Payment < ApplicationRecord
  belongs_to :order

  validates :amount, :order, presence: true
end
