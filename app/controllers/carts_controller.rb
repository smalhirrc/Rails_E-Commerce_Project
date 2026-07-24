class CartsController < ApplicationController
    def add
        product_id = params[:id].to_s
        quantity = params[:quantity].to_i

        session[:cart] ||= {}
        session[:cart][product_id] ||= 0
        session[:cart][product_id] += quantity

        redirect_to "/cart"
    end

    def index
        @cart = session[:cart] || {}
    end

    def edit
        product_id = params[:id].to_s
        new_quantity = params[:new_quantity].to_i

        if new_quantity <= 0
            session[:cart].delete(product_id)

            redirect_to "/cart"
        else
            session[:cart][product_id] = new_quantity

            redirect_to "/cart"
        end
    end

    def remove
        product_id = params[:id].to_s

        session[:cart].delete(product_id)

        redirect_to "/cart"
    end
end
