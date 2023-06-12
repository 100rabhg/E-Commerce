ActiveAdmin.register OrderItem do
  
  permit_params :quantity, :order_id, :product_id
  # config.clear_action_items!
  form do |f|
    f.inputs do
      f.input :order, collection: Order.all.map { |t| [t.id] }
      f.input :product
      f.input :quantity
    end
    f.actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:quantity, :sub_total, :order_id, :product_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
