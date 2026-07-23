class CategoriesController < ApplicationController
    def show
        @category = Category.find(params[:id])

        @products = @category.products.includes(image_attachment: :blob).page(params[:page]).per(4)

        @categories = Category.all
    end
end
