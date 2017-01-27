class Product < ActiveRecord::Base
	belongs_to :category
  scope :by_name, -> (name_query) { where("name like ?", "%#{name_query}%") }
  scope :by_category, -> (cat) { where(category: cat) }
  scope :by_price_range, -> (min, max) { where(price: min..max) }
end
