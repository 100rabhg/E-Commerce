class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :quantity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
  validates :sub_total, presence: true, numericality: {minimum: 1}

  before_validation :set_sub_total

  def set_sub_total
      self.sub_total = self.product.price * self.quantity
  end
end
