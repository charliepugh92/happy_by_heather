class ChangeOrderReferencesToEnums < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :payment_type_id, :integer
    add_column :orders, :payment_type, :integer

    remove_column :orders, :delivery_type_id, :integer
    add_column :orders, :delivery_type, :integer

    remove_column :orders, :order_status_id, :integer
    add_column :orders, :status, :integer, default: 0, null: false
  end
end
