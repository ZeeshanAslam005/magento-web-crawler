desc 'script to scrape products from https://magento-test.finology.com.my'
require 'open-uri'

task scrape_magento_web: :environment do
  BASE_URL = 'https://magento-test.finology.com.my/index.php/breathe-easy-tank.html'.freeze
  href_array = []
  href_array << BASE_URL
  href_array << Product.unvisited_links #due to some reason if job stop, start visiting only unvisiting links
  href_array = href_array.flatten #will return a one-dimensional array
  puts "STARTING"
  until href_array.empty?

    href = href_array.shift #removes the first href from array
    next if Product.find_by(href: href, visited: true) #do not go further if link aleay visited

    product = ProductHandler.new(href)
    product.parse
    product.save
    product.save_realted_links
    href_array << Product.unvisited_links if href_array.empty? #insert unvisited links if current links are visited
    href_array = href_array.flatten
  end
  puts "FINISHED: SCRAPED ONLY THOSE PAGES WHO ARE NOT ALEADY VISITED"
end
