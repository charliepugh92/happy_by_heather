module Market
  module Customers
    class AddressController < ApplicationController
      before_action :load_customer

      def new
        @customer_address = @customer.build_customer_address
      end

      def create
        @customer_address = @customer.build_customer_address(request_params)

        if @customer_address.save
          redirect_to market_order_path(id: @customer_address.customer.orders.last)
        else
          render 'new'
        end
      end

      private

      def load_customer
        @customer = Customer.find(params[:customer_id])
      end

      def request_params
        params.require(:customer_address).permit(:line_one, :line_two, :city, :state, :zip_code, :country)
      end
    end
  end
end
