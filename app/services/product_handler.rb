require 'open-uri'

class ProductHandler
  attr_reader :href, :document, :name, :price, :details, :extra_information
  def initialize(href)
    @href = href
  end


  def parse
    @name = name
    @price = price
    @details = details
    @extra_information = extra_information
  end

  def print
    puts ({
      href: @href,
     name: @name,
     price: @price,
     details: @details,
     extra_information: @extra_information
    }).to_s
  end

  def save
    Product.find_or_create_by(href: @href).update(
      name: @name,
      price: @price,
      details: @details,
      extra_information: @extra_information,
      visited: true
    )
    print
  end


  def save_realted_links
    related_hrefs.each do |href|
      Product.find_or_create_by(href: href) #only create if link not already exist
    end
  end

  private

   def document
      @document ||= begin
         Nokogiri::HTML(open(@href))
      end
   end

   def name
      document.css('main.page-main h1.page-title span.base').text
   end

   def price
      document.css('main.page-main div.product-info-price span.price').text
   end

   def details
      document.css('main.page-main div.product.attribute.description').text
   end

   def extra_information
      document.css('main.page-main #product-attribute-specs-table tbody').text
   end

   def related_hrefs
      hrefs = document.css('ol.products.list.items.product-items').css('a')
       hrefs.map { |element| element['href'] }.compact.uniq - ['#']
   end
end
