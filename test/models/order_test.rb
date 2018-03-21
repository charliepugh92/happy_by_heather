require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:price)
    should validate_presence_of(:order_info)
    should validate_presence_of(:delivery_type)
    should validate_presence_of(:payment_type)
    should validate_presence_of(:customer)
    should validate_presence_of(:title)
  end
end
