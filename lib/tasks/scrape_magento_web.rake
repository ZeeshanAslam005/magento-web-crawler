desc "script to scrape products from magento-test.finology.com"
require 'open-uri'

task scrape_magento_web: :environment do
  BASE_URL = 'https://magento-test.finology.com.my/index.php/breathe-easy-tank.html'.freeze
  href_array = []
  href_array << BASE_URL
  href_array << Product.unvisited_links
  href_array = href_array.flatten
  until href_array.empty?

    href = href_array.shift
    next if Product.find_by(href: href, visited: true)

    product = ProductHandler.new(href)
    product.parse
	product.save
    product.save_realted_links
    href_array << Product.unvisited_links if href_array.empty?
    href_array = href_array.flatten
  end
end
