class ProductsController < ApplicationController
  before_action :set_params
  before_action :set_category, only: :search

  def search
  end

  def set_params
    @params = params.permit(:q, :minprice, :maxprice, :cat)
  end


  def set_category
    @category = Category.find_by(id: @params[:cat].to_i)
    render json: { errors: ['category not found' ] }, status: :not_found and return unless @category
  end
end
