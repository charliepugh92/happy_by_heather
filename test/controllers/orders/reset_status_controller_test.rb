require 'test_helper'

module Orders
  class ResetStatusControllerTest < ActionDispatch::IntegrationTest
    context Orders::ResetStatusController do
      setup do
        @order = create(:order)
        @path = order_reset_status_path(order_id: @order.id)
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
          should 'change status from in_progress to not_started' do
            @order.in_progress!

            assert_changes '@order.reload.not_started?', from: false, to: true do
              patch @path

              assert_redirected_to customer_path(id: @order.customer_id)
            end
          end

          should 'change status from shipped to not_started' do
            @order.shipped!

            assert_changes '@order.reload.not_started?', from: false, to: true do
              patch @path

              assert_redirected_to customer_path(id: @order.customer_id)
            end
          end

          should 'change status from complete to not_started' do
            @order.complete!

            assert_changes '@order.reload.not_started?', from: false, to: true do
              patch @path

              assert_redirected_to customer_path(id: @order.customer_id)
            end
          end
        end
      end
    end
  end
end
