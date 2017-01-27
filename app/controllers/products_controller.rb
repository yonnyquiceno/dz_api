class ProductsController < ApplicationController
  before_action :set_params
  before_action :set_category, :set_price_range, only: :search

  def search
    @query = @params[:q]
    if @query
      if @category.nil?
        @products = Product.by_name_query(@query).by_price_range(@price_range[0], @price_range[1])
      else
        @products = Product.by_name_query(@query).by_category(@category).by_price_range(@price_range[0], @price_range[1])
      end
      if @products == []
        render(json: { errors: ['no matching products'] }, status: :not_found)
      else
        render json: @products
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
    @category = Category.find_by(id: @params[:cat].to_i)
    if @params[:cat] && !@category && (@params[:cat] != '')
      render(json: { errors: ['category not found'] }, status: :not_found)
    end
  end

  def set_price_range
    @price_range = []
    (@params[:minprice] == nil || @params[:minprice] == '') ? @price_range[0] = 0 : @price_range[0] = @params[:minprice].to_i
    (@params[:maxprice] == nil || @params[:maxprice] == '') ? @price_range[1] = Float::INFINITY : @price_range[1] = @params[:maxprice].to_i
  end
end
