FactoryGirl.define do
  factory :product do
      name { Faker::Commerce.product_name }
      price { Faker::Commerce.price }
      image { Faker::Placeholdit.image("50x50") }
  end
end
