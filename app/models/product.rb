class Product < ActiveRecord::Base
  require 'fuzzystringmatch'

  belongs_to :category

  scope :by_category, -> (cat) { where(category: cat) }
  scope :by_price_range, -> (min, max) { where(price: min..max) }

  def self.sort_by_similarity(prods, query)
    jarow = FuzzyStringMatch::JaroWinkler.create(:native)
    @scores = {}
    prods.each do |prod|
      @scores[prod] = jarow.getDistance(prod.name.downcase, query)
    end
    @scores = @scores.sort_by { |_key, value| value }.reverse.flatten
    @sorted_products = @scores.select { |sc| sc.class == Product }
  end
end
