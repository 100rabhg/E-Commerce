module Api
  class ProductsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_devise_api_token!, except: %i[index show]

    def index
      @products = Product.all
      render json: @products
    end

    def show
      @product = Product.find(params[:id])
      render json: @product
    end

    def create
      @product = Product.new(product_params.merge(store: current_devise_api_user.store))
      if @product.save
        render json: @product
      else
        render error: { error: 'Unable to create Product' }, status: 400
      end
    end

    def update
      @product = Product.find(params[:id])
      if @product&.update(product_params)
        render json: { message: 'Product successfully updated.' }, status: 200
      else
        render error: { error: 'Unable to create product' }, status: 400
      end
    end

    def destroy
      @product = Product.find(params[:id])
      if @product&.destroy
        render json: { message: 'Product successfully deleted.' }, status: 200
      else
        render error: { error: 'Unable to destroy product' }, status: 400
      end
    end

    private

    def product_params
      params.require(:product).permit(:title, :description, :price, :quantity, :category_id, :store_id)
    end
  end
end
