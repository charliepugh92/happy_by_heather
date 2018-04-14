module Market
  class OrdersController < ApplicationController
    before_action :load_customer, only: %i[new create]
    before_action :load_order, only: %i[show]

    def show; end

    def new
      @order = @customer.orders.new
    end

    def create
      @order = @customer.orders.new(request_params)

      if @order.save
        if @order.ship_to_customer?
          redirect_to new_market_customer_address_path(customer_id: @order.customer_id)
        else
          redirect_to market_order_path(id: @order.id)
        end
      else
        render 'new'
      end
    end

    private

    def load_customer
      @customer = Customer.find(params[:customer_id])
    end

    def load_order
      @order = Order.find(params[:id])
    end

    def request_params
      new_params = params.require(:order).permit(:order_info, :title, :price, :delivery_type)

      new_params['delivery_type'] = new_params['delivery_type'].to_i

      new_params
    end
  end
end
