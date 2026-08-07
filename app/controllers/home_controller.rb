class HomeController < ApplicationController
  def index
    @products = Product.includes(:category, image_attachment: :blob).all.page(params[:page]).per(4)
    @categories = Category.all
  end

  def signup
    @provinces = Province.all

    if request.post?

        email = params[:user_email]
        password = params[:password]
        province = params[:province_id].to_i
        city = params[:user_city]
        street_address = params[:user_street_address]
        postal_code = params[:user_postal_code]

        begin
          @province = Province.find(province)
          @customer = Customer.find_by(email: email)

          if @customer
            @user = User.create!(email: email) do |user|
              user.password = password
            end

            @customer.update!(province: @province, user: @user)

            @address = Address.find_or_create_by!(customer: @customer, city: city, postal_code: postal_code, street_address: street_address)
          else
            @user = User.create!(email: email) do |user|
              user.password = password
            end

            @customer = Customer.create!(email: email, province: @province, user: @user)

            @address = Address.find_or_create_by!(customer: @customer, city: city, postal_code: postal_code, street_address: street_address)
          end

          sign_in(@user)
          # "Welcome! Your account was created successfully."
          redirect_to root_path, notice: "Welcome! Your account was created successfully." and return
        rescue ActiveRecord::RecordInvalid => e
          flash.now[:alert] = e.message
          render :signup, status: :unprocessable_entity and return
        end
    end
  end

  def login
    if request.post?
      session[:cart] = {}

      email = params[:customer_email]
      password = params[:password]

      user = User.find_by(email: email)

      if user && user.valid_password?(password)
        sign_in(user)
        
        redirect_to root_path, notice: "Logged in successfully. Welcome back!" and return
      else
        flash.now[:alert] = "Invalid email or password."
        render :login, status: :unprocessable_entity and return
      end
    end
  end


  def logout
    session[:cart] = {}

    sign_out(:user)

    redirect_to root_path, notice: "Signed out successfully."
  end

  def profile
    @provinces = Province.all

    @user = current_user

    # @signed_in_customer_addresses = []
    # customer = Customer.find_by(user_id: @user["id"])

    # customer.addresses.each do |address|
    #   address_object = {
    #     "id" => address.id,
    #     "street_address" => address.street_address,
    #     "city" => address.city,
    #     "postal_code" => address.postal_code,
    #     "full_format" => "#{address.street_address}, #{address.city}, #{address.postal_code}"
    #   }

    #   @signed_in_customer_addresses << address_object
    # end

    if request.post?
      name = params[:user_name]
      email = params[:user_email]
      phone = params[:user_phone]
      province_id = params[:province_id]

      @customer = Customer.find_or_initialize_by(email: email)
      @customer.name = name
      @customer.phone = phone
      @customer.province_id = province_id
      @customer.user_id = @user["id"]

      if @customer.save
        flash[:notice] = "Profile updated successfully!"
        redirect_to profile_path
      else
        flash.now[:alert] = @customer.errors.full_messages.to_sentence
        render :profile
      end
    end
  end

  def add_address
    @customer = User.find(current_user["id"]).customer
    Address.find_or_create_by!(city: params[:user_city], customer: @customer, postal_code: params[:user_postal_code], street_address: params[:user_street_address])

    flash[:notice] = "Address added successfully!"
    redirect_to profile_path
  end
end
