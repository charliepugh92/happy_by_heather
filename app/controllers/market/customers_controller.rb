module Market
  class CustomersController < ApplicationController
    def new
      @customer = Customer.new
    end

    def create
      @customer = Customer.new(request_params)
      if @customer.save
        redirect_to new_market_customer_order_path(customer_id: @customer.id)
      else
        render 'new'
      end
    end

    private

    def request_params
      params.require(:customer).permit(:first_name, :last_name, :email, :phone_number)
    end
  end
end
