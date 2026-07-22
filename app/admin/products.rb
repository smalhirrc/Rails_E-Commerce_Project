ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :price, :category_id, :image

  preserve_default_filters!
  remove_filter :image_attachment
  remove_filter :image_blob

  # Image display in product row
  index do
    selectable_column
    id_column
    column :name
    column :category do |product|
      product.category&.name || "Uncategorized"
    end
    column :price do |product|
      number_to_currency(product.price)
    end
    column :image do |product|
      if product.image.attached?
        image_tag url_for(product.image), class: "admin-thumb", style: "width: 50px; height: auto;"
      else
        "No Image"
      end
    end
    actions
  end

  # Form field for image
  form html: { multipart: true } do |f|
    f.inputs "Product Details" do
      f.input :category, as: :select, collection: Category.all.map { |c| [ c.name, c.id ] }, include_blank: "Select Category"
      f.input :name
      f.input :price
      f.input :image, as: :file, hint: f.object.image.attached? ? image_tag(url_for(f.object.image), style: "width: 100px; height: auto;") : "No image uploaded yet"
    end
    f.actions
  end

  # Successfully uploaded image show
  show do
    attributes_table do
      row :id
      row :name
      row :category
      row :price do |product|
        number_to_currency(product.price)
      end
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), style: "max-width: 300px; height: auto;"
        else
          "No image uploaded"
        end
      end
    end
    active_admin_comments
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:category_id, :name, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
