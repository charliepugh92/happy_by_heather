require 'test_helper'

module Orders
  class CompleteControllerTest < ActionDispatch::IntegrationTest
    context Orders::CompleteController do
      setup do
        @order = create(:order, status: Order.statuses[:shipped])
        @path = order_complete_path(order_id: @order.id)
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
          should 'change status to complete' do
            assert_changes '@order.reload.complete?', from: false, to: true do
              patch @path

              assert_redirected_to customer_path(id: @order.customer_id)
            end
          end
        end
      end
    end
  end
end
