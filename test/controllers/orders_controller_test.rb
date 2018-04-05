require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  context OrdersController do
    context '#index' do
      setup do
        create(:order, status: Order.statuses[:not_started])
        create(:order, status: Order.statuses[:in_progress])
        create(:order, status: Order.statuses[:shipped])
        create(:order, status: Order.statuses[:complete])

        @path = orders_path
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
        @order = create(:order)
        @path = orders_path(id: @order.id)
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
        @customer = create(:customer)
        @path = new_customer_order_path(customer_id: @customer.id)
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
        @path = customer_orders_path(customer_id: @customer.id)
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
            order: attributes_for(:order)
          }
        end

        should 'be success' do
          assert_difference 'Order.count' do
            post @path, params: @params
          end

          order = Order.last
          assert_equal @customer.id, order.customer_id
          assert_equal @params[:order][:order_info], order.order_info
          assert_equal @params[:order][:price], order.price.to_s
          assert order.paypal?
          assert order.ship_to_customer?
          assert order.not_started?

          assert_redirected_to customer_path(id: order.customer_id)
        end
      end
    end

    context '#edit' do
      setup do
        @order = create(:order)
        @path = edit_order_path(id: @order.id)
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
        @order = create(:order)
        @path = order_path(id: @order.id)
      end

      while_not_signed_in do
        should 'redirect to login' do
          patch @path

          assert_redirected_to login_path
        end
      end

      while_signed_in do
        setup do
          @params = { order: { price: Faker::Number.decimal(3, 2) } }
        end

        should 'be success' do
          assert_changes '@order.reload.price', from: @order.price, to: @params[:order][:price].to_d do
            patch @path, params: @params

            assert_redirected_to order_path(id: @order.id)
          end
        end
      end
    end

    context '#destroy' do
      setup do
        @order = create(:order)
        @path = order_path(id: @order.id)
      end

      while_not_signed_in do
        should 'redirect to login' do
          delete @path

          assert_redirected_to login_path
        end
      end

      while_signed_in do
        should 'be success' do
          assert_difference 'Order.count', -1 do
            delete @path

            assert_redirected_to customer_path(id: @order.customer_id)
          end
        end
      end
    end
  end
end
