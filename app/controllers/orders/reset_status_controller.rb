module Orders
  class ResetStatusController < ApplicationController
    before_action :load_order

    def update
      @order.not_started!
      redirect_to customer_path(id: @order.customer_id)
    end

    private

    def load_order
      @order = Order.find(params[:order_id])
    end
  end
end
