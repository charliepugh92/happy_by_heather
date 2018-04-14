module Orders
  class ShipController < ApplicationController
    before_action :load_order

    def update
      @order.shipped!
      redirect_to customer_path(id: @order.customer_id)
    end

    private

    def load_order
      @order = Order.find(params[:order_id])
    end
  end
end
