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

    def checkout
    @provinces = Province.all

        if user_signed_in?
            @user = current_user
            @addresses = @user.customer.addresses || []

            @signed_in_customer_addresses = @addresses.map do |address|
            {
                id: address.id,
                street_address: address.street_address,
                city: address.city,
                postal_code: address.postal_code,
                full_format: "#{address.street_address}, #{address.city}, #{address.postal_code}"
            }
            end
        end

        if request.post?
            name = params[:customer_name]
            email = params[:customer_email]
            phone = params[:customer_phone_number]
            province_id = params[:customer_province_id]

            @products = Product.where(id: session[:cart].keys)

            if user_signed_in?
                begin
                    ActiveRecord::Base.transaction do
                        @customer = Customer.find_or_create_by!(email: email) do |customer|
                            customer.name = name
                            customer.phone = phone
                            customer.province_id = province_id
                            customer.user_id = @user.id
                        end

                        @address = Address.find(params[:address_id])

                        sub_total = 0
                        @products.each do |product|
                            quantity = session[:cart][product.id.to_s].to_i
                            sub_total += product.price * quantity
                        end
                        tax_rate = @customer.province.tax
                        grand_total = sub_total + (sub_total * tax_rate)

                        @order = Order.create!(
                        customer: @customer,
                        address: @address,
                        order_date: Time.current,
                        tax_rate: tax_rate,
                        total_price: grand_total
                        )

                        @products.each do |product|
                        OrderItem.create!(
                            order: @order,
                            product_id: product.id,
                            quantity: session[:cart][product.id.to_s].to_i,
                            price: product.price
                        )
                        end
                    end
                    session[:cart] = {}

                    redirect_to "/cart/order/#{@order.id}" and return

                rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
                    flash.now[:alert] = e.message.gsub("Validation failed: ", "").split(", ").join("<br>").html_safe
                    render :checkout, status: :unprocessable_entity and return
                end

            else
                street_address = params[:customer_street_address]
                city = params[:customer_city]
                postal_code = params[:customer_postal_code]

                begin
                    ActiveRecord::Base.transaction do
                        @customer = Customer.find_or_initialize_by(email: email)
                        @customer.update!(
                            name: name,
                            phone: phone,
                            province_id: province_id
                        )

                        @address = Address.find_or_create_by!(
                        city: city,
                        customer: @customer,
                        postal_code: postal_code,
                        street_address: street_address
                        )

                        subtotal = 0
                        @products.each do |product|
                            quantity = session[:cart][product.id.to_s].to_i
                            subtotal += product.price * quantity
                        end

                        tax_rate = @customer.province.tax
                        grand_total = subtotal + (subtotal * tax_rate)

                        @order = Order.create!(
                        customer: @customer,
                        address: @address,
                        order_date: Time.current,
                        tax_rate: tax_rate,
                        total_price: grand_total
                        )

                        @products.each do |product|
                        OrderItem.create!(
                            order: @order,
                            product_id: product.id,
                            quantity: session[:cart][product.id.to_s].to_i,
                            price: product.price
                        )
                        end
                    end

                    session[:cart] = {}

                    redirect_to "/cart/order/#{@order.id}" and return

                rescue ActiveRecord::RecordInvalid => e
                    flash.now[:alert] = e.message.gsub("Validation failed: ", "").split(", ").join("<br>").html_safe
                    render :checkout, status: :unprocessable_entity and return
                end
            end
        end
    end

    def order
        @order = Order.find(params[:id])
        @customer = @order.customer
        @address = @order.address

        @order_items = OrderItem.where(order_id: @order.id)

        @total = 0
        @order_items.each do |item|
            @total += item.price * item.quantity
        end

        province = @customer.province
        @tax = province&.tax
        @tax_amount = @total * @tax
        @grand_total = @total + @tax_amount
    end
end
