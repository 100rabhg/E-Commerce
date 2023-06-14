ActiveAdmin.register Order do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  # Uncomment all parameters which should be permitted for assignment
  permit_params :status, :user_id, :total_price, :address, :pincode, :state, :payment
  config.clear_action_items!

  form do |f|
    f.inputs do
      f.input :user
      f.input :total_price
      f.input :address
      f.input :pincode
      f.input :state, collection: CS.states(:IN).values
      f.input :payment
    end
    f.actions
  end
  # or
  # permit_params do
  #   permitted = [:total_price, :purchase_date, :status, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  filter :orderItems
end
