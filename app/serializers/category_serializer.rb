class CategorySerializer < ActiveModel::Serializer
  attributes :id,
             :trans
  def trans
    trans = { en: object.trans(object.name, 'en'), es: object.trans(object.name, 'es') }
  end
end
