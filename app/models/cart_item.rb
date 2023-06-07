class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, minimum: 1 }

  before_save :set_sub_total

  private

  def set_sub_total
    self.sub_total = product.price * quantity
  end
end
