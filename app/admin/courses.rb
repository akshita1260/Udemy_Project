ActiveAdmin.register Course do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :status, :video, :user_id, :category_id, :price
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :status, :video, :user_id, :category_id, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    selectable_column
    id_column
    column :name
    column :description
    column :status
    column :video
    column :price
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :status
      f.input :price
    end
    f.actions
  end
end
