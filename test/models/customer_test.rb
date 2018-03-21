require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:email)
    should validate_presence_of(:phone_number)
  end
end
