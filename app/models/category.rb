class Category < ApplicationRecord
    has_many :product
    validates :name, presence: true, length: {minimum: 3}
end