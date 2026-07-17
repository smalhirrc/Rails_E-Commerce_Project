class ProductsController < ApplicationController
  def show
    @product = Product.includes(:category).find(params[:id])
  end
end
