# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# AdminUser.find_or_create_by!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

require 'rubygems'
require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require 'faker'

Product.destroy_all
Category.destroy_all

url = 'https://www.canadianwoodworker.com/product-category/hand-tools/'

html_content = URI.open(url)
main_page = Nokogiri::HTML(html_content)

category_links = main_page.css("ul.columns-4 li.product-category")

discovered_categories = []

category_links.each do |link|
    discovered_categories << {
        name: link.css("h2.woocommerce-loop-category__title").text.strip,
        url: link.at_css("a")['href']
    }
end

discovered_categories.each do |category|
    db_category = Category.find_or_create_by!(name: category[:name])

    category_html = URI.open(category[:url])
    category_page = Nokogiri::HTML(category_html)

    products_on_page = category_page.css('h2.woocommerce-loop-product__title')

    products_on_page.each do |prod|
        product_name = prod.text.strip
        product_price = Faker::Number.number(digits: 2)

        Product.create!(
            name: product_name,
            price: product_price,
            category: db_category
        )
    end
end

extra_category = Category.find_or_create_by!(name: "Safety & Accessories")

Product.create!(name: "Estwing 16oz Straight Claw Hammer", price: 44.99, category: extra_category)
Product.create!(name: "Stanley Classic Retractable Utility Knife", price: 11.50, category: extra_category)
Product.create!(name: "Channellock 10-Inch Tongue and Groove Pliers", price: 29.95, category: extra_category)
Product.create!(name: "Irwin QUICK-GRIP 6-Inch Bar Clamp", price: 19.99, category: extra_category)
Product.create!(name: "Milwaukee 25-ft Magnetic Tape Measure", price: 24.97, category: extra_category)
Product.create!(name: "DeWalt 12-Piece Screw Driver Set", price: 34.99, category: extra_category)
Product.create!(name: "Empire 12-Inch True Blue Combination Square", price: 18.50, category: extra_category)
Product.create!(name: "3M Professional Safety Glasses (Clear)", price: 14.25, category: extra_category)
Product.create!(name: "Knipex Cobra 10-Inch Water Pump Pliers", price: 49.50, category: extra_category)
Product.create!(name: "Wera Kraftform Plus 6-Piece Screwdriver Set", price: 39.99, category: extra_category)
