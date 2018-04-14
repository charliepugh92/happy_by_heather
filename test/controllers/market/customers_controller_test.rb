require 'test_helper'

module Market
  class CustomersControllerTest < ActionDispatch::IntegrationTest
    context Market::CustomersController do
      context '#new' do
        setup do
          @path = new_market_customer_path
        end

        while_not_signed_in do
          should 'redirect to login' do
            get @path

            assert_redirected_to login_path
          end
        end

        while_signed_in do
          should 'be success' do
            get @path

            assert_response :success
          end
        end
      end

      context '#create' do
        setup do
          @path = market_customers_path
        end

        while_not_signed_in do
          should 'redirect to login' do
            post @path

            assert_redirected_to login_path
          end
        end

        while_signed_in do
          setup do
            @params = {
              customer: attributes_for(:customer)
            }
          end

          should 'be success' do
            assert_difference 'Customer.count' do
              post @path, params: @params
            end

            customer = Customer.last
            assert_equal @params[:customer][:first_name], customer.first_name
            assert_equal @params[:customer][:last_name], customer.last_name
            assert_equal @params[:customer][:email], customer.email
            assert_equal @params[:customer][:phone_number], customer.phone_number

            assert_redirected_to new_market_customer_order_path(customer_id: customer.id)
          end
        end
      end
    end
  end
end
