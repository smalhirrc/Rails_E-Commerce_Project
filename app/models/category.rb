class Category < ApplicationRecord
    has_many :products

    validates :name,
              presence: true,
              length: { minimum: 2, maximum: 100 },
              uniqueness: true

  def self.ransackable_associations(auth_object = nil)
    [ "products" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "id_value", "name", "updated_at" ]
  end
end
