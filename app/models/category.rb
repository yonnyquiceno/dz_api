class Category < ActiveRecord::Base
  has_many :products
  def trans(word, locale)
    return I18n.t("models.category.#{word.downcase}", locale: locale.to_sym)
  end
end
