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

# require 'rubygems'
# require 'bundler/setup'
# require 'open-uri'
# require 'nokogiri'
# require 'faker'

# Product.destroy_all
# Category.destroy_all

# url = 'https://www.canadianwoodworker.com/product-category/hand-tools/'

# html_content = URI.open(url)
# main_page = Nokogiri::HTML(html_content)

# category_links = main_page.css("ul.columns-4 li.product-category")

# discovered_categories = []

# category_links.each do |link|
#     discovered_categories << {
#         name: link.css("h2.woocommerce-loop-category__title").text.strip,
#         url: link.at_css("a")['href']
#     }
# end

# discovered_categories.each do |category|
#     db_category = Category.find_or_create_by!(name: category[:name])

#     category_html = URI.open(category[:url])
#     category_page = Nokogiri::HTML(category_html)

#     products_on_page = category_page.css('h2.woocommerce-loop-product__title')

#     products_on_page.each do |prod|
#         product_name = prod.text.strip
#         product_price = Faker::Number.number(digits: 2)

#         Product.create!(
#             name: product_name,
#             price: product_price,
#             category: db_category
#         )
#     end
# end

# extra_category = Category.find_or_create_by!(name: "Safety & Accessories")

# Product.create!(name: "Estwing 16oz Straight Claw Hammer", price: 44.99, category: extra_category)
# Product.create!(name: "Stanley Classic Retractable Utility Knife", price: 11.50, category: extra_category)
# Product.create!(name: "Channellock 10-Inch Tongue and Groove Pliers", price: 29.95, category: extra_category)
# Product.create!(name: "Irwin QUICK-GRIP 6-Inch Bar Clamp", price: 19.99, category: extra_category)
# Product.create!(name: "Milwaukee 25-ft Magnetic Tape Measure", price: 24.97, category: extra_category)
# Product.create!(name: "DeWalt 12-Piece Screw Driver Set", price: 34.99, category: extra_category)
# Product.create!(name: "Empire 12-Inch True Blue Combination Square", price: 18.50, category: extra_category)
# Product.create!(name: "3M Professional Safety Glasses (Clear)", price: 14.25, category: extra_category)
# Product.create!(name: "Knipex Cobra 10-Inch Water Pump Pliers", price: 49.50, category: extra_category)
# Product.create!(name: "Wera Kraftform Plus 6-Piece Screwdriver Set", price: 39.99, category: extra_category)

# Page.find_or_create_by!(slug: 'about') do |p|
#   p.title = 'About Us'
#   p.content = 'Welcome to our company story...'
# end

# Page.find_or_create_by!(slug: 'contact') do |p|
#   p.title = 'Contact Us'
#   p.content = 'Get in touch with us via email@example.com...'
# end

# provinces = [
#     { name: "Alberta", tax: 0.050 },
#     { name: "British Columbia", tax: 0.120 },
#     { name: "Manitoba", tax: 0.120 },
#     { name: "New Brunswick", tax: 0.150 },
#     { name: "Newfoundland and Labrador", tax: 0.150 },
#     { name: "Nova Scotia", tax: 0.150 },
#     { name: "Ontario", tax: 0.130 },
#     { name: "Prince Edward Island", tax: 0.150 },
#     { name: "Quebec", tax: 0.14975 },
#     { name: "Saskatchewan", tax: 0.110 }
# ]

# provinces.each do |province|
#     Province.find_or_create_by!(name: province[:name]) do |p|
#         p.tax = province[:tax]
#     end
# end

# db/seeds.rb
provinces_data = [
  { name: "Alberta",                   code: "AB", gst: 0.05, pst: 0.00, hst: 0.00, tax: 0.05 },
  { name: "British Columbia",          code: "BC", gst: 0.05, pst: 0.07, hst: 0.00, tax: 0.12 },
  { name: "Manitoba",                  code: "MB", gst: 0.05, pst: 0.07, hst: 0.00, tax: 0.12 },
  { name: "New Brunswick",             code: "NB", gst: 0.00, pst: 0.00, hst: 0.15, tax: 0.15 },
  { name: "New Newfoundland & Lab.",   code: "NL", gst: 0.00, pst: 0.00, hst: 0.15, tax: 0.15 },
  { name: "Northwest Territories",     code: "NT", gst: 0.05, pst: 0.00, hst: 0.00, tax: 0.05 },
  { name: "Nova Scotia",               code: "NS", gst: 0.00, pst: 0.00, hst: 0.14, tax: 0.14 },
  { name: "Nunavut",                   code: "NU", gst: 0.05, pst: 0.00, hst: 0.00, tax: 0.05 },
  { name: "Ontario",                   code: "ON", gst: 0.00, pst: 0.00, hst: 0.13, tax: 0.13 },
  { name: "Prince Edward Island",      code: "PE", gst: 0.00, pst: 0.00, hst: 0.15, tax: 0.15 },
  { name: "Quebec",                    code: "QC", gst: 0.05, pst: 0.09975, hst: 0.00, tax: 0.14975 },
  { name: "Saskatchewan",              code: "SK", gst: 0.05, pst: 0.06, hst: 0.00, tax: 0.11 },
  { name: "Yukon",                     code: "YT", gst: 0.05, pst: 0.00, hst: 0.00, tax: 0.05 }
]

provinces_data.each do |data|
  province = Province.find_or_initialize_by(name: data[:name])
  province.update!(
    gst: data[:gst],
    pst: data[:pst],
    hst: data[:hst],
    tax: data[:tax]
  )
end

