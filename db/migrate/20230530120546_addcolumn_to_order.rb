class AddcolumnToOrder < ActiveRecord::Migration[7.0]
  def change
      add_column :orders, :address, :string
      add_column :orders, :mobile_number, :string
      add_column :orders, :pincode, :string
      add_column :orders, :state, :string
  end
end
