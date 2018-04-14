require 'test_helper'

module Market
  module Customers
    class AddressControllerTest < ActionDispatch::IntegrationTest
      context Market::Customers::AddressController do
        context '#new' do
          setup do
            @customer = create(:customer)
            create(:order, customer: @customer)
            @path = new_market_customer_address_path(customer_id: @customer.id)
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
            @customer = create(:customer)
            create(:order, customer: @customer)
            @path = market_customer_address_path(customer_id: @customer.id)
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
                customer_address: attributes_for(:customer_address, :with_line_two, :with_country)
              }
              @params[:customer_address].delete(:customer_id)
            end

            should 'be success' do
              assert_difference 'CustomerAddress.count' do
                post @path, params: @params
              end

              customer_address = CustomerAddress.last
              assert_equal @params[:customer_address][:line_one], customer_address.line_one
              assert_equal @params[:customer_address][:line_two], customer_address.line_two
              assert_equal @params[:customer_address][:city], customer_address.city
              assert_equal @params[:customer_address][:state], customer_address.state
              assert_equal @params[:customer_address][:zip_code], customer_address.zip_code
              assert_equal @params[:customer_address][:country], customer_address.country
              assert_equal @customer, customer_address.customer

              assert_redirected_to market_order_path(id: customer_address.customer.orders.last)
            end
          end
        end
      end
    end
  end
end
