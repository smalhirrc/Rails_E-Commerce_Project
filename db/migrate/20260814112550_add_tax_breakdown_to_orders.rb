class AddTaxBreakdownToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :gst_amount, :decimal
    add_column :orders, :pst_amount, :decimal
    add_column :orders, :hst_amount, :decimal
  end
end
