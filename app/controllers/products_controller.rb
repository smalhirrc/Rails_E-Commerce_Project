class ProductsController < ApplicationController
    def index
        @products = Product.includes(:category, image_attachment: :blob)

        if params[:search].present?
            @products = @products.where("products.name LIKE ?", "%#{params[:search]}%")
        end

        if params[:category_id].present?
            @products = @products.where("products.category_id = ?", params[:category_id])
            @category = Category.find(params[:category_id])
        end

        @products = @products.page(params[:page]).per(4)
    end

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
