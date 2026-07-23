class ProductsController < ApplicationController
    def show
        @product = Product.includes(:category, image_attachment: :blob).find(params[:id])
    end
end
