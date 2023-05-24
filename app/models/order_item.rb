class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
  validates :sub_total, presence: true, numericality: {greater_than: 0}
 
  before_validation :set_sub_total

  def set_sub_total
      self.sub_total =self.product.price * self.quantity
  end
end