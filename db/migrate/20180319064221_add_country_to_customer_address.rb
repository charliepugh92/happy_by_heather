class AddCountryToCustomerAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :customer_addresses, :country, :string
  end
end
