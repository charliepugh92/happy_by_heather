class AddTitleToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :title, :string, null: false, default: 'Custom Order'
    change_column :orders, :title, :string, default: nil
  end
end
