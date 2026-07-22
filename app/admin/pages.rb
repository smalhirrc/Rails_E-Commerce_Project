ActiveAdmin.register Page do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :slug, :title, :content

  actions :index, :show, :edit, :update

  index do
    selectable_column
    column :slug
    column :title
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Page Content" do
      f.input :slug, input_html: { disabled: true }
      f.input :title
      f.input :content, as: :text
    end
    f.actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:slug, :title, :content]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
