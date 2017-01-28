class Product < ActiveRecord::Base
  require 'fuzzystringmatch'

  belongs_to :category

  scope :by_category, -> (cat) { where(category: cat) }
  scope :by_price_range, -> (min, max) { where(price: min..max) }

  def self.sort_by_similarity(prods, query, threshold = 0)
    jarow = FuzzyStringMatch::JaroWinkler.create(:native)
    @scores = {}
    prods.each do |prod|
      @scores[prod] = jarow.getDistance(prod.name.downcase, query)
    end
    avoid_non_relevant_results(threshold) if threshold
    @scores = @scores.sort_by { |_key, value| value }.reverse.flatten
    @sorted_products = @scores.select { |sc| sc.class == Product }
  end

  def self.avoid_non_relevant_results(threshold)
    @scores = @scores.select { |_key, value| value > threshold }
  end
end
