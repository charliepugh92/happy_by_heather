module Customers
  class AddressController < ApplicationController
    before_action :load_customer
    before_action :load_customer_address, only: [:edit, :update, :destroy]

    def new
      @customer_address = CustomerAddress.new(customer: @customer)
    end

    def create
      @customer_address = CustomerAddress.new(request_params)
      @customer_address.customer = @customer
      if @customer_address.save
        redirect_to customer_path(id: @customer.id)
      else
        render 'new'
      end
    end

    def edit; end

    def update
      if @customer_address.update(request_params)
        redirect_to customer_path(id: @customer_address.customer_id)
      else
        render 'edit'
      end
    end

    def destroy
      @customer_address.destroy
      redirect_to customer_path(id: @customer_address.customer_id)
    end

    private

    def request_params
      params.require(:customer_address).permit(:line_one, :line_two, :city, :state, :zip_code, :country)
    end

    def load_customer
      @customer ||= Customer.includes(:customer_address).find(params[:customer_id])
    end

    def load_customer_address
      @customer_address ||= @customer.customer_address
    end
  end
end