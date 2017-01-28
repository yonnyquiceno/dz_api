class ProductsController < ApplicationController
  before_action :set_params
  before_action :set_category, :set_price_range, only: :suggest

  def suggest
    @query = @params[:q]
    if @query && @query != ''
      @prods = if @cat.nil?
                 Product.by_price_range(@p_r[0], @p_r[1])
               else
                 @cat.products.by_price_range(@p_r[0], @p_r[1])
               end
      @sorted_products = Product.sort_by_similarity(@prods, @query)
      if @sorted_products == []
        render(json: { errors: ['no matching products'] }, status: :not_found)
      else
        render json: @sorted_products
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
    @cat = Category.joins(:products).find_by(id: @params[:cat].to_i)
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
