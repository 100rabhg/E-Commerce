class OrderItemChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :order_items, :subt_otal, :sub_total
  end
end
