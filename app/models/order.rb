class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :address
  has_many :payments
  has_many :order_items

  validates :customer,
            presence: true

  validates :address,
            presence: true

  validates :order_date,
            presence: true

  validates :tax_rate,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0
            }

  validates :total_price,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0
            }
end
