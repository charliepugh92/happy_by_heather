require 'test_helper'

module Orders
  class ShipControllerTest < ActionDispatch::IntegrationTest
    context Orders::ShipController do
      setup do
        @order = create(:order, status: Order.statuses[:in_progress])
        @path = order_ship_path(order_id: @order.id)
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
          should 'change status to shipped' do
            assert_changes '@order.reload.shipped?', from: false, to: true do
              patch @path

              assert_redirected_to order_path(id: @order.id)
            end
          end
        end
      end
    end
  end
end
