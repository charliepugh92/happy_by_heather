require 'test_helper'

module Customers
  class AddressControllerTest < ActionDispatch::IntegrationTest
    context Customers::AddressController do
      setup do
        @customer = create(:customer)
      end

      context '#new' do
        setup do
          @path = new_customer_address_path(customer_id: @customer.id)
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
          @path = customer_address_path(customer_id: @customer.id)
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

            assert_redirected_to customer_path(id: @customer.id)
          end
        end
      end

      context '#edit' do
        setup do
          @customer_address = create(:customer_address, customer: @customer)
          @path = edit_customer_address_path(customer_id: @customer.id)
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

      context '#update' do
        setup do
          @customer_address = create(:customer_address, customer: @customer)
          @path = customer_address_path(customer_id: @customer.id)
        end

        while_not_signed_in do
          should 'redirect to login' do
            patch @path

            assert_redirected_to login_path
          end
        end

        while_signed_in do
          setup do
            @params = { customer_address: { line_one: Faker::Address.street_address } }
          end

          should 'be success' do
            assert_changes '@customer_address.reload.line_one', from: @customer_address.line_one, to: @params[:customer_address][:line_one] do
              patch @path, params: @params

              assert_redirected_to customer_path(id: @customer.id)
            end
          end
        end
      end

      context '#destroy' do
        setup do
          @customer_address = create(:customer_address, customer: @customer)
          @path = customer_address_path(customer_id: @customer.id)
        end

        while_not_signed_in do
          should 'redirect to login' do
            delete @path

            assert_redirected_to login_path
          end
        end

        while_signed_in do
          should 'be success' do
            assert_difference 'CustomerAddress.count', -1 do
              delete @path

              assert_redirected_to customer_path(id: @customer.id)
            end
          end
        end
      end
    end
  end
end
