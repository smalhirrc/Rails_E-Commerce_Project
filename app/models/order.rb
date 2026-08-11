class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :address

  has_many :payments
  has_many :order_items
end
