require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:email)
    should validate_presence_of(:phone_number)
  end

  context 'callbacks' do
    should 'destroy orders and address when destroyed' do
      order = create(:order)
      customer = order.customer
      create(:customer_address, customer: customer)

      assert_difference 'CustomerAddress.count', -1 do
        assert_difference 'Order.count', -1 do
          customer.destroy
        end
      end
    end
  end
end
