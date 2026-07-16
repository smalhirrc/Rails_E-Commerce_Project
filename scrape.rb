require 'rubygems'
require 'bundler/setup'
require 'open-uri'
require 'nokogiri'
require 'faker'

url = 'https://www.leevalley.com/en-ca/shop/tools/hand-tools'

html_content = URI.open(url)
main_page = Nokogiri::HTML(html_content)

category_links = main_page.css("section.css-iqmvbd a.css-aetovd")

discovered_categories = []

category_links.each do |link|
    discovered_categories << {
        name: link.css("p.css-1uop52s").text.strip,
        url: "https://leevalley.com" + link['href']
    }
end

discovered_categories.each do |category|
    db_category = Category.find_or_create_by!(name: category[:name])

    category_html = URI.open(category[:url])
    category_page = Nokogiri::HTML(category_html)

    products_on_page = category_page.css('section.css-iqmvbd a.css-aetovd p.css-1uop52s')

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
