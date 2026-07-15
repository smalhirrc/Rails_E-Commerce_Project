class CreateAddresses < ActiveRecord::Migration[8.1]
  def change
    create_table :addresses do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :street_address
      t.string :city
      t.string :postal_code

      t.timestamps
    end
  end
end
