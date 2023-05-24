class Product < ApplicationRecord
  belongs_to :store
  belongs_to :category
  has_many :orderItem
  has_many :order, through: :orderItem

  validates :title, presence: true, length:{minimum: 3, maximum: 20}
  validates :description, length: {maximum: 1000}
  validates :price, presence: true, numericality: {greater_than: 0}
  validates :quantity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
end