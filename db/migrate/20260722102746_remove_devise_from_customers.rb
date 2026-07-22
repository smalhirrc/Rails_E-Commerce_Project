class RemoveDeviseFromCustomers < ActiveRecord::Migration[8.1]
  def change
    remove_column :customers, :encrypted_password, :string, default: "", null: false
    remove_column :customers, :reset_password_token, :string
    remove_column :customers, :reset_password_sent_at, :datetime
    remove_column :customers, :remember_created_at, :datetime

    if index_exists?(:customers, :email)
      remove_index :customers, :email
    end
  end
end
