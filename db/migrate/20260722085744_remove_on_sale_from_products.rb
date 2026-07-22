class RemoveOnSaleFromProducts < ActiveRecord::Migration[8.1]
  def change
    remove_column :products, :on_sale, :boolean
  end
end
