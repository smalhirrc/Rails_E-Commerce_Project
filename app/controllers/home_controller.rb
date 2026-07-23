class HomeController < ApplicationController
  def index
    @products = Product.includes(:category, image_attachment: :blob).all.page(params[:page]).per(4)
    @categories = Category.all
  end
end
