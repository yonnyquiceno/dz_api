class ProductSerializer < ActiveModel::Serializer
  attributes  :name,
              :price,
              :image

  def root
    'suggestions'
  end
  belongs_to :category
end
