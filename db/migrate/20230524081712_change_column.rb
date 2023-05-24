class ChangeColumn < ActiveRecord::Migration[7.0]
  def change
    remove_reference :orders, :customer, foreign_key: true, index: true
    add_reference :orders, :user, foreign_key: true, index: true
  end
end
