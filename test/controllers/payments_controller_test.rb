class PaymentsControllerTest < ActionDispatch::IntegrationTest
  context PaymentsController do
    context '#new' do
      setup do
        order = create(:order)
        @path = new_order_payment_path(order_id: order.id)
      end

      while_not_signed_in do
        should 'redirect to login' do
          get @path

          assert_redirected_to login_path
        end
      end

      while_signed_in do
        should 'show new payment page' do
          get @path

          assert_response :success
        end
      end
    end

    context '#create' do
      setup do
        @order = create(:order)
        @params = { payment: attributes_for(:payment) }
        @path = order_payments_path(order_id: @order.id)
      end

      while_not_signed_in do
        should 'redirect to login' do
          post @path, params: @params

          assert_redirected_to login_path
        end
      end

      while_signed_in do
        should 'create new payment' do
          assert_difference 'Payment.count' do
            post @path, params: @params

            assert_redirected_to order_path(id: @order.id)
          end

          payment = Payment.last
          assert_equal @order, payment.order
          assert_equal @params[:payment][:amount], payment.amount.to_s
          assert_equal @params[:payment][:confirmation_number], payment.confirmation_number
        end
      end
    end

    context '#edit' do
      setup do
        @payment = create(:payment)
        @path = edit_payment_path(id: @payment.id)
      end

      while_not_signed_in do
        should 'redirect to login' do
          get @path

          assert_redirected_to login_path
        end
      end

      while_signed_in do
        should 'show edit payment page' do
          get @path

          assert_response :success
        end
      end
    end

    context '#update' do
      setup do
        @payment = create(:payment)
        @path = payment_path(id: @payment.id)
        @params = { payment: attributes_for(:payment) }
      end

      while_not_signed_in do
        should 'redirect to login' do
          patch @path, params: @params

          assert_redirected_to login_path
        end
      end

      while_signed_in do
        should 'update payment' do
          assert_changes '@payment.reload.amount.to_s', from: @payment.amount.to_s, to: @params[:payment][:amount] do
            assert_changes '@payment.reload.confirmation_number', from: @payment.confirmation_number, to: @params[:payment][:confirmation_number] do
              patch @path, params: @params

              assert_redirected_to order_path(id: @payment.order_id)
            end
          end
        end
      end
    end

    context '#destroy' do
      setup do
        @payment = create(:payment)
        @path = payment_path(id: @payment.id)
      end

      while_not_signed_in do
        should 'redirect to login' do
          delete @path

          assert_redirected_to login_path
        end
      end

      while_signed_in do
        should 'show new payments page' do
          assert_difference 'Payment.count', -1 do
            delete @path

            assert_redirected_to order_path(id: @payment.order_id)
          end
        end
      end
    end
  end
end
