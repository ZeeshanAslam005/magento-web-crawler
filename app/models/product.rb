class Product < ApplicationRecord
  scope :unvisited_links, -> { where(visited: false).map(&:href) }
end
