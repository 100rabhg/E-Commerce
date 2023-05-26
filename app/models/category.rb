class Category < ApplicationRecord
  has_many :product, dependent: :destroy
  validates :title, presence: true, length: { minimum: 3 }
end
