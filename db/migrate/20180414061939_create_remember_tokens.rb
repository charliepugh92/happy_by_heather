class CreateRememberTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :remember_tokens do |t|
      t.integer :user_id, null: false
      t.string :remember_digest, null: false
    end

    remove_column :users, :remember_digest
  end
end
