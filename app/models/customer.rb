class Customer < ApplicationRecord
  belongs_to :province

  has_many :addresses
  has_many :orders

  belongs_to :user, optional: true
end
