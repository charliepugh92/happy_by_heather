require 'test_helper'

class CustomerAddressTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:line_one)
    should validate_presence_of(:city)
    should validate_presence_of(:state)
    should validate_presence_of(:zip_code)
    should validate_presence_of(:customer)
  end
end
