class Customer < ApplicationRecord
  belongs_to :province

  has_many :addresses

  belongs_to :user, optional: true
end
