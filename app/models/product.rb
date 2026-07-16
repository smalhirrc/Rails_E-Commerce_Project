class Product < ApplicationRecord
  belongs_to :category

  def self.ransackable_associations(auth_object = nil)
    [ "category_id" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "category_id", "created_at", "id", "name", "price", "updated_at" ]
  end
end
