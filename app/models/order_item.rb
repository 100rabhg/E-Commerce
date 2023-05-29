class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, presence: true, numericality: { only_integer: true, minimum: 1 }
  validates :sub_total, presence: true, numericality: { minimum: 1 }

  before_validation :set_sub_total_quantity

  def set_sub_total_quantity
    self.quantity = 1 if quantity.nil?
    self.sub_total = product.price * quantity
  end
end
