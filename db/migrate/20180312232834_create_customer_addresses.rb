class CreateCustomerAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_addresses do |t|
      t.references :customer, null: false
      t.string :line_one, null: false
      t.string :line_two
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip_code, null: false

      t.timestamps
    end
  end
end
