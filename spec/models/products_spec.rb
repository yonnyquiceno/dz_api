require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'relations' do
    it { should belong_to(:category) }
  end

  describe 'named scopes' do
    cat1 = FactoryGirl.create(:category)
    cat2 = FactoryGirl.create(:category)
    p1 = FactoryGirl.create(:product, price:9000, category: cat1)
    p2 = FactoryGirl.create(:product, price:300, category: cat2)

    describe 'Product.by_category' do
      describe Product.by_category(cat1) do
        it { is_expected.to include(p1) }
        it { should_not include(p2) }
      end
    end

    describe 'Product.by_price_range' do
      describe Product.by_price_range(200, 400) do
        it { is_expected.to include(p2) }
        it { should_not include(p1) }
      end
    end
  end

  describe 'Product#sort_by_similarity' do
    let(:prods) { FactoryGirl.create_list(:product, 5) }
    let(:query) { prods.last.name }
    it 'returns expected product at first' do
      expect(Product.sort_by_similarity(prods, query).first).to eq prods.last
    end
  end
end
