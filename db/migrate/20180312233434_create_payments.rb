class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :order_id
      t.decimal :amount
      t.string :confirmation_number

      t.timestamps
    end
  end
end
