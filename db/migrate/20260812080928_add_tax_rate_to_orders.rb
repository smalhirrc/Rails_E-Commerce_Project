class AddTaxRateToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :tax_rate, :decimal
  end
end
