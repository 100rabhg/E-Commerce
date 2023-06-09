ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :email, :role, :password, :password_confirmation
  # index do
  #   column :name
  #   column :email
  # end
  # #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  filter :encrypted_password
  filter :reset_password_token
  filter :confirmation_token
  filter :unconfirmed_email

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :role
    column :sign_in_count
    column :last_sign_in_at
    column :confirmed_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role
    end
    f.actions
  end
end
