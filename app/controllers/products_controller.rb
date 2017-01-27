class ProductsController < ApplicationController
  before_action :set_params
  before_action :set_category, only: :search

  def search
    @query = @params[:q]

    if @query
      @products = Product.by_name_query(@query).by_category(@category) if @query && @category
      @products = Product.by_name_query(@query) if @query && !@category
      if @products == []
        render(json: { errors: ['no matching products in the category'] }, status: :not_found)
      else
        render json: @products
      end
    else
      render(json: { errors: ['please introduce search query'] }, status: :not_found)
    end
  end

  def set_params
    @params = params.permit(:q, :minprice, :maxprice, :cat)
  end

  def set_category
    @category = Category.find_by(id: @params[:cat].to_i)
    if @params[:cat] && !@category && (@params[:cat] != '')
      render(json: { errors: ['category not found'] }, status: :not_found)
    end
  end
end
