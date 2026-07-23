class ProductsController < ApplicationController
    def show
        @product = Product.includes(:category, image_attachment: :blob).find(params[:id])
    end

    def on_sale
        @on_sale = Product.includes(:category, image_attachment: :blob).where(on_sale: true).page(params[:page]).per(4)
    end

    def new_products
        @new_products = Product.includes(:category, image_attachment: :blob).where("created_at >= ?", 3.days.ago).page(params[:page]).per(4)
    end
end
