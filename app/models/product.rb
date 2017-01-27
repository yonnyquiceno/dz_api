class Product < ActiveRecord::Base
	belongs_to :category
  scope :by_name_query, -> (name_query) { where("name like ?", "%#{name_query}%") }
  scope :by_category, -> (cat) { where(category: cat) }
end
