ActiveAdmin.register Category do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name

  # filter :name
  # filter :created_at

  # index do
  #   selectable_column
  #   id_column
  #   column :name
  #   column "Total Products" do |category|
  #     category.products.count
  #   end
  #   column :created_at
  #   actions
  # end
  #
  # or
  #
  # permit_params do
  #   permitted = [:name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
