require 'test_helper'

module Orders
  class StartControllerTest < ActionDispatch::IntegrationTest
    context Orders::StartController do
      setup do
        @order = create(:order, status: Order.statuses[:not_started])
        @path = order_start_path(order_id: @order.id)
      end

      context '#update' do
        while_not_signed_in do
          should 'redirect to login' do
            assert_no_changes '@order.reload.status' do
              patch @path

              assert_redirected_to login_path
            end
          end
        end

        while_signed_in do
          should 'change status to in_progress' do
            assert_changes '@order.reload.in_progress?', from: false, to: true do
              patch @path

              assert_redirected_to customer_path(id: @order.customer_id)
            end
          end
        end
      end
    end
  end
end
