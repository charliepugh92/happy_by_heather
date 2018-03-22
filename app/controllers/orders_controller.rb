class OrdersController < ApplicationController
  before_action :load_order, only: %i[show edit update destroy]
  before_action :load_customer, only: %i[new create]

  def index
    @orders = Order.all.group_by(&:status)
  end

  def show; end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(request_params)
    @order.customer = @customer
    if @order.save
      # TODO: change this to order view page, once it's built
      redirect_to customer_path(id: @order.customer_id)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    @order.update_attributes(request_params)
    if @order.save
      redirect_to order_path(id: @order.id)
    else
      render 'edit'
    end
  end

  def destroy
    @order.destroy
    redirect_to customer_path(id: @order.customer_id)
  end

  private

  def load_order
    @order ||= Order.find(params[:id])
  end

  def load_customer
    @customer ||= Customer.find(params[:customer_id])
  end

  def request_params
    new_params = params.require(:order).permit(:order_info, :title, :price, :payment_type, :delivery_type)

    new_params['delivery_type'] = new_params['delivery_type'].to_i if new_params['delivery_type']
    new_params['payment_type'] = new_params['payment_type'].to_i if new_params['payment_type']

    new_params
  end
end
