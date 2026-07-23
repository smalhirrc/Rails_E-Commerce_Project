class AddOnSaleToProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :on_sale, :boolean, default: false, null: false
  end
end
