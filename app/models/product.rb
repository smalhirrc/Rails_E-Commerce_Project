class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true

  has_one_attached :image
  # has_many_attached :images

  def self.ransackable_associations(auth_object = nil)
    [ "category_id" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "category_id", "created_at", "id", "name", "price", "updated_at" ]
  end
end
