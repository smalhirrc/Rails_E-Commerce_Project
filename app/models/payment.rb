class Payment < ApplicationRecord
  belongs_to :order

  validates :amount,
            presence: true,
            numericality: { greater_than: 0 }

  validates :payment_method,
            presence: true,
            length: { maximum: 50 }

  validates :status,
            presence: true,
            inclusion: {
              in: %w[pending completed failed refunded],
              message: "is not a valid payment status"
            }

  validates :transaction_id,
            presence: true,
            uniqueness: true,
            length: { maximum: 255 }

  validates :order,
            presence: true
end
