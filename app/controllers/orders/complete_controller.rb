module Orders
  class CompleteController < ApplicationController
    before_action :load_order

    def update
      @order.complete!
      redirect_to order_path(id: @order.id)
    end

    private

    def load_order
      @order ||= Order.find(params[:order_id])
    end
  end
end
