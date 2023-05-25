class HomeController < ApplicationController
    def index
        @products = Product.where(quantity:(1..)).order(updated_at: :desc).limit(20)
    end

    def search
        @query = params[:query]
        sanitize_query = ("%"+Product.sanitize_sql_like(@query)+"%").downcase
        @products = Product.joins(:category).where("categories.title like ? ", sanitize_query).or(Product.where('products.title like ?', sanitize_query).or(Product.where('description LIKE ?',sanitize_query)))
    end

    def show
        @product = Product.find_by(id:params[:id])
    end
end
