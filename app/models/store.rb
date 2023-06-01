class Store < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :description, length: { maximum: 500 }
end
