class Product < ApplicationRecord
  belongs_to :store
  belongs_to :category
  has_many :cartItems, dependent: :destroy
  has_many :orderItems, dependent: :destroy
  has_many :orders, through: :orderItem
  has_one_attached :image, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3, maximum: 20 }
  validates :description, length: { maximum: 1000 }
  validates :price, presence: true, numericality: { minimum: 1 }
  validates :quantity, presence: true, numericality: { only_integer: true, minimum: 0 }
end
