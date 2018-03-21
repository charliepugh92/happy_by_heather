class RemoveEnumLikeTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :delivery_types
    drop_table :order_statuses
    drop_table :payment_types
  end
end
