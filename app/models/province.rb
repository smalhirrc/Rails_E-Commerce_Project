class Province < ApplicationRecord
    has_many :customers
    has_many :users

    validates :name,
              presence: true,
              length: { minimum: 2, maximum: 100 },
              uniqueness: true

    validates :tax,
              presence: true,
              numericality: {
              greater_than_or_equal_to: 0
              }
end
