require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  context CustomersController do
    context '#index' do
      setup do
        create(:customer)
        create(:customer)

        @path = customers_path
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

    context '#show' do
      setup do
        @customer = create(:customer)
        @path = customer_path(id: @customer.id)
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

    context '#new' do
      setup do
        @path = new_customer_path
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
        @path = customers_path
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

          assert_redirected_to customer_path(id: customer.id)
        end
      end
    end

    context '#edit' do
      setup do
        @customer = create(:customer)
        @path = edit_customer_path(id: @customer.id)
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
        @customer = create(:customer)
        @path = customer_path(id: @customer.id)
      end

      while_not_signed_in do
        should 'redirect to login' do
          patch @path

          assert_redirected_to login_path
        end
      end

      while_signed_in do
        setup do
          @params = { customer: { phone_number: Faker::PhoneNumber.phone_number } }
        end

        should 'be success' do
          assert_changes '@customer.reload.phone_number', from: @customer.phone_number, to: @params[:customer][:phone_number] do
            patch @path, params: @params

            assert_redirected_to customer_path(id: @customer.id)
          end
        end
      end
    end

    context '#destroy' do
      setup do
        @customer = create(:customer)
        @path = customer_path(id: @customer.id)
      end

      while_not_signed_in do
        should 'redirect to login' do
          delete @path

          assert_redirected_to login_path
        end
      end

      while_signed_in do
        should 'be success' do
          assert_difference 'Customer.count', -1 do
            delete @path

            assert_redirected_to customers_path
          end
        end
      end
    end
  end
end
