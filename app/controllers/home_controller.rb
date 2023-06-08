class HomeController < ApplicationController
  before_action :if_merchant_redirected_store

  def index
    @products = Product.where(quantity: (1..)).order(updated_at: :desc).limit(20)
  end

  def search
    @query = params[:query]
    sanitize_query = "%#{Product.sanitize_sql_like(@query)}%"
    @products = Product.joins(:category).where('categories.title like ? ', sanitize_query)
                       .or(Product.where('products.title like ?',
                                         sanitize_query).or(Product.where('description LIKE ?', sanitize_query)))
  end

  def if_merchant_redirected_store
    redirect_to store_path if !current_user.nil? && current_user.merchant?
  end

end
