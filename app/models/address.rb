class Address < ApplicationRecord
  belongs_to :customer
  has_many :orders

  validates :city,
            presence: true,
            length: { maximum: 100 }

  validates :street_address,
            presence: true,
            length: { maximum: 100 }

  validates :postal_code,
            presence: true,
            format: {
              with: /\A[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d\z/,
              message: "must be a valid Canadian postal code"
            }

  validates :customer,
            presence: true
end
