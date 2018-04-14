require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:amount)
    should validate_presence_of(:order)
    should validate_presence_of(:payment_type)
  end
end
