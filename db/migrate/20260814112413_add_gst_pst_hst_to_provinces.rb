class AddGstPstHstToProvinces < ActiveRecord::Migration[8.1]
  def change
    add_column :provinces, :gst, :decimal
    add_column :provinces, :pst, :decimal
    add_column :provinces, :hst, :decimal
  end
end
