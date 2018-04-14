require 'test_helper'

module Market
  class PaymentsControllerTest < ActionDispatch::IntegrationTest
    context Market::PaymentsController do
      context '#new' do
        setup do
          @order = create(:order)
          @path = new_market_order_payment_path(order_id: @order.id)
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
          @order = create(:order)
          @path = market_order_payments_path(order_id: @order.id)
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
              payment: attributes_for(:payment)
            }
            @params[:payment].delete(:order_id)
          end

          should 'be success' do
            assert_difference 'Payment.count' do
              post @path, params: @params
            end

            payment = Payment.last
            assert_equal @order, payment.order
            assert_equal @params[:payment][:amount], payment.amount.to_s
            assert_equal @params[:payment][:confirmation_number], payment.confirmation_number

            # TODO: check mailer gets called

            assert_redirected_to new_market_customer_path
          end
        end
      end
    end
  end
end
