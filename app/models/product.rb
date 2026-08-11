class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 255 }

  validates :price,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :on_sale,
            inclusion: {
              in: [ true, false ]
            }

  validates :category,
            presence: true

  def self.ransackable_associations(auth_object = nil)
    [ "category_id" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "category_id", "created_at", "id", "name", "price", "updated_at", "on_sale" ]
  end
end
