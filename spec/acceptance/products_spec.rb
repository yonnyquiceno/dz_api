require 'spec_helper'
require 'rails_helper'
require 'rspec_api_documentation/dsl'
require 'acceptance_helper'

resource 'Product' do
  get 'suggestions' do
    parameter 'q', 'Search term', required: true
    parameter 'minprice', 'Minimum product price'
    parameter 'maxprice', 'Maximum product price'
    parameter 'cat', 'Product Category'
    parameter 'thold', 'threshold (avoid irrelevant results)'

    example 'Get Suggestions with name only' do
      explanation "This query return autocomplete product suggestions of all categories and prices for a given name(q) query"

      cat1 = FactoryGirl.create(:category, name: "apparatus")
      cat2 = FactoryGirl.create(:category, name: "apparatus")

      p1 = FactoryGirl.create(:product, name: "MEGALLOY N.2 AMALGAMA 300u", category: cat1)
      p2 = FactoryGirl.create(:product,  name: "MEGALLOY N.1 AMALGAMA 200u", category: cat1)
      p4 = FactoryGirl.create(:product, category: cat2)
      p5 = FactoryGirl.create(:product, category: cat2)

      do_request(q: "megaly n2300")

      expect(response_status).to eq(200)
      # expect(response_body).to include_json(
    end

    example 'Get Suggestions searching with name and category' do
      explanation "This query return autocomplete product suggestions of all prices for a given name(q) and category"

      cat1 = FactoryGirl.create(:category, name: "apparatus")
      cat2 = FactoryGirl.create(:category, name: "apparatus")

      p1 = FactoryGirl.create(:product, name: "MEGALLOY N.2 AMALGAMA 300u", category: cat1)
      p2 = FactoryGirl.create(:product,  name: "MEGALLOY N.1 AMALGAMA 200u", category: cat1)
      p4 = FactoryGirl.create(:product, category: cat2)
      p5 = FactoryGirl.create(:product, category: cat2)

      do_request(q: "megaly n2300", cat: cat1.id)

      expect(response_status).to eq(200)
      # expect(response_body).to include_json(
    end

    example 'Get Suggestions searching with name, category, and price range' do
      explanation "This query return autocomplete product suggestions for a given name(q), category, minprice and maxprice"

      cat1 = FactoryGirl.create(:category, name: "apparatus")
      cat2 = FactoryGirl.create(:category, name: "apparatus")

      p1 = FactoryGirl.create(:product, price: 1000.50, name: "MEGALLOY N.2 AMALGAMA 300u", category: cat1)
      p2 = FactoryGirl.create(:product, price: 1200.60, name: "MEGALLOY N.1 AMALGAMA 200u", category: cat1)
      p4 = FactoryGirl.create(:product, price: 400.34, category: cat2)
      p5 = FactoryGirl.create(:product, price: 500.29, category: cat2)

      do_request(q: "megaly n2300", cat: cat1.id, minprice: 800, maxprice: 1500)

      expect(response_status).to eq(200)
      # expect(response_body).to include_json(
    end

    example 'Get Suggestions searching with name and threshold' do
      explanation "This query return autocomplete product suggestions for a given name(q) and thold"

      cat1 = FactoryGirl.create(:category, name: "apparatus")
      cat2 = FactoryGirl.create(:category, name: "apparatus")

      p1 = FactoryGirl.create(:product, price: 1000.50, name: "MEGALLOY N.2 AMALGAMA 300u", category: cat1)
      p2 = FactoryGirl.create(:product, price: 400.34, category: cat1)
      p3 = FactoryGirl.create(:product, price: 400.34, category: cat1)
      p4 = FactoryGirl.create(:product, price: 400.34, category: cat1)
      p5 = FactoryGirl.create(:product, price: 400.34, category: cat2)
      p6 = FactoryGirl.create(:product, price: 500.29, category: cat2)

      do_request(q: "MEGALLOY N.2 AMALGAMA 300u0", thold: 0.9)

      expect(response_status).to eq(200)
      # expect(response_body).to include_json(
    end
  end
end
