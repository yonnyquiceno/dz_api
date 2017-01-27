class ProductsSerializer < ActiveModel::Serializer
  attributes  :name,
              :price,
              :image

              # @en = t("." + cat_name.downcase, locale: :en)
              # @es = t("." + cat_name.downcase, locale: :es)
end
