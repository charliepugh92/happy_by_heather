class CustomersController < ApplicationController
  before_action :load_customer, only: %i[edit update destroy]

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.includes(:customer_address, :orders).find(params[:id])
    @customer_orders = @customer.orders.all.group_by(&:status)
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(request_params)
    if @customer.save
      redirect_to customer_path(id: @customer.id)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    @customer.update_attributes(request_params)
    if @customer.save
      redirect_to customer_path(id: @customer.id)
    else
      render 'edit'
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path
  end

  private

  def load_customer
    @customer = Customer.find(params[:id])
  end

  def request_params
    params.require(:customer).permit(:first_name, :last_name, :email, :phone_number)
  end
end
