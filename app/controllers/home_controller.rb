class HomeController < ApplicationController
    def index
        @categories = Category.order(updated_at: :desc).limit(20)
        @stores = Store.order(updated_at: :desc).limit(20)
        @products = Product.where(quantity:(1..)).order(updated_at: :desc).limit(20)
    end

    def search

    end
end
