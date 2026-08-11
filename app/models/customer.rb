class Customer < ApplicationRecord
  belongs_to :province
  has_many :addresses
  has_many :orders
  belongs_to :user, optional: true

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 100 }

  validates :email,
            presence: true,
            format: {
              with: URI::MailTo::EMAIL_REGEXP,
              message: "must be a valid email address"
            },
            uniqueness: true

  validates :phone,
            presence: true,
            format: {
              with: /\A(?:\+1[\s.-]?)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/,
              message: "must be a valid phone number"
            }

  validates :province,
            presence: true
end
