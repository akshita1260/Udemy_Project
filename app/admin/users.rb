ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :name, :email, :password, :type
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :password, :type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |u|
    u.inputs "User" do
      u.input :name
      u.input :email
      u.input :password
      u.input :type
    end
    u.actions
  end
end
