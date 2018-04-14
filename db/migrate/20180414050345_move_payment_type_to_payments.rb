class MovePaymentTypeToPayments < ActiveRecord::Migration[5.1]
  def up
    add_column :payments, :payment_type, :integer, default: 0, null: false
    change_column :payments, :payment_type, :integer, default: nil

    Order.all.each do |o|
      o.payments.each do |p|
        p.update(payment_type: o.payment_type)
      end
    end

    remove_column :orders, :payment_type
  end

  def down
    add_column :orders, :payment_type, :integer

    Order.all.each do |o|
      if o.payments.first
        o.update(payment_type: o.payments.first.payment_type)
      else
        o.update(payment_type: Order.payment_types[:paypal])
      end
    end

    remove_column :payments, :payment_type
  end
end
