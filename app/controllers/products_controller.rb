class ProductsController < ApplicationController
  before_action :set_params
  before_action :set_category, :set_price_range, only: :search

  def search
    @query = @params[:q]
    if @query && @query != ''
      if @cat.nil?
        @prods = Product.by_name(@query).by_price_range(@p_r[0], @p_r[1]).sort_by &:price
      else
        @prods = Product.by_name(@query).by_category(@cat).by_price_range(@p_r[0], @p_r[1]).sort_by &:price
      end
      if @prods == []
        render(json: { errors: ['no matching products'] }, status: :not_found)
      else
        render json: @prods
      end
    else
      render(json: { errors: ['please introduce search query'] }, status: :not_found)
    end
  end

  private

  def set_params
    @params = params.permit(:q, :minprice, :maxprice, :cat)
  end

  def set_category
    @cat = Category.find_by(id: @params[:cat].to_i)
    if @params[:cat] && !@cat && (@params[:cat] != '')
      render(json: { errors: ['category not found'] }, status: :not_found)
    end
  end

  def set_price_range
    @p_r = []
    @params[:minprice].nil? || @params[:minprice] == '' ? @p_r[0] = 0 : @p_r[0] = @params[:minprice].to_i
    @params[:maxprice].nil? || @params[:maxprice] == '' ? @p_r[1] = Float::INFINITY : @p_r[1] = @params[:maxprice].to_i
  end
end
