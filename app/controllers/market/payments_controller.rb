module Market
  class PaymentsController < ApplicationController
    before_action :load_order

    def new
      @payment = @order.payments.new
    end

    def create
      @payment = @order.payments.new(request_params)

      if @payment.save
        send_confirmation_email(@payment.order)

        redirect_to new_market_customer_path
      else
        render 'new'
      end
    end

    private

    def send_confirmation_email(order)
      CustomerNotifierMailer.delay.market_order_confirmation(order.id)
    end

    def load_order
      @order = Order.find(params[:order_id])
    end

    def request_params
      new_params = params.require(:payment).permit(:amount, :confirmation_number, :payment_type)

      new_params['payment_type'] = new_params['payment_type'].to_i if new_params['payment_type']

      new_params
    end
  end
end
