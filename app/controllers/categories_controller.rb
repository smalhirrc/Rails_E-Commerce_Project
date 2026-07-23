class CategoriesController < ApplicationController
    def show
        @category = Category.find(params[:id])

        @products = @category.products.includes(image_attachment: :blob)

        @categories = Category.all
    end
end
