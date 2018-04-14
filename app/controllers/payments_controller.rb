class PaymentsController < ApplicationController
  before_action :load_order, only: %i[new create]
  before_action :load_payment, only: %i[edit update destroy]

  def new
    @payment = Payment.new(order: @order)
  end

  def create
    @payment = @order.payments.new(request_params)

    if @payment.save
      redirect_to order_path(id: @order.id)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @payment.update(request_params)
      redirect_to order_path(id: @payment.order_id)
    else
      render 'edit'
    end
  end

  def destroy
    @payment.destroy
    redirect_to order_path(id: @payment.order_id)
  end

  private

  def load_order
    @order = Order.find(params[:order_id])
  end

  def load_payment
    @payment = Payment.find(params[:id])
  end

  def request_params
    new_params = params.require(:payment).permit(:amount, :confirmation_number, :payment_type)

    new_params['payment_type'] = new_params['payment_type'].to_i if new_params['payment_type']

    new_params
  end
end
