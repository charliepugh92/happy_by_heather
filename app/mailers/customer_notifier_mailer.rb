class CustomerNotifierMailer < ApplicationMailer
  def market_order_confirmation(order_id)
    @order = Order.find(order_id)

    mail(to: @order.customer.email, subject: 'Your Custom Order with HappyByHeather')
  end
end
