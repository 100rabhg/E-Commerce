class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, minimum: 1 }
  validates :sub_total, presence: true, numericality: { minimum: 1 }

  before_validation :set_sub_total_quantity

  scope :merchant_order_item, lambda { |user_id|
                                joins(:order, product: :store).where('stores.user_id = ?', user_id).where(order: Order.not_cancelled).order(:status)
                              }

  private

  def set_sub_total_quantity
    self.sub_total = product.price * quantity unless quantity.nil?
  end
end
