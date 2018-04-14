class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false
      t.references :payment_type, null: false
      t.references :delivery_type
      t.text :order_info, null: false
      t.decimal :price, null: false

      t.timestamps
    end
  end
end
