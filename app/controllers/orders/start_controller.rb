module Orders
  class StartController < ApplicationController
    before_action :load_order

    def update
      @order.in_progress!
      redirect_to customer_path(id: @order.customer_id)
    end

    private

    def load_order
      @order ||= Order.find(params[:order_id])
    end
  end
end
