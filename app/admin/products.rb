ActiveAdmin.register Product do
  permit_params :title, :description, :price, :quantity, :store_id, :category_id

  filter :orderItems
  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :price, min: 0.01
      f.input :quantity, min: 0
      f.input :store
      f.input :category
    end
    f.actions
  end
end
