class CreateOrderStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :order_statuses do |t|
      t.string :name
    end
  end
end