class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :quantity, presence: true, numericality: { only_integer: true, minimum: 1 }
  validates :sub_total, presence: true, numericality: { minimum: 1 }

  before_validation :set_quantity, on: :create
  before_validation :set_sub_total

  private

  def set_sub_total
    self.sub_total = product.price * quantity
  end
  
  def set_quantity
    self.quantity = 1 if self.quantity.nil?
  end

end
