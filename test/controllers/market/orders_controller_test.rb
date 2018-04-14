require 'test_helper'

module Market
  class OrdersControllerTest < ActionDispatch::IntegrationTest
    context Market::OrdersController do
      context '#show' do
        setup do
          @order = create(:order)
          create(:customer_address, customer: @order.customer)
          @path = market_order_path(id: @order.id)
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
          @path = new_market_customer_order_path(customer_id: @customer.id)
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
          @path = market_customer_orders_path(customer_id: @customer.id)
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
              order: attributes_for(:order, customer_id: @customer.id)
            }
            @params[:order].delete(:customer_id)
          end

          context 'when ship to customer' do
            should 'be success' do
              assert_difference 'Order.count' do
                post @path, params: @params
              end

              order = Order.last
              assert_equal @customer.id, order.customer_id
              assert_equal @params[:order][:order_info], order.order_info
              assert_equal @params[:order][:price], order.price.to_s
              assert order.ship_to_customer?
              assert order.not_started?

              assert_redirected_to new_market_customer_address_path(customer_id: @customer.id)
            end
          end

          context 'when customer pick up' do
            setup do
              @params[:order][:delivery_type] = Order.delivery_types[:pick_up]
            end

            should 'go to order confirmation page' do
              assert_difference 'Order.count' do
                post @path, params: @params
              end

              order = Order.last
              assert_equal @customer.id, order.customer_id
              assert_equal @params[:order][:order_info], order.order_info
              assert_equal @params[:order][:price], order.price.to_s
              assert order.pick_up?
              assert order.not_started?

              assert_redirected_to market_order_path(id: order.id)
            end
          end
        end
      end
    end
  end
end
