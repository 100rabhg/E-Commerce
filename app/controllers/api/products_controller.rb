class Api::ProductsController < ApplicationController
    def index 
        @products = Product.all
        render json: @products
    end

    def show 
        @product = Product.find(params[:id])
        render json: @product
    end

    def create
        @product =Product.new(product_params)
        if @product.save
            render json: @product
        else 
            render error: {error: 'Unable to create Product'}, status: 400
        end
    end

    def update 
        @product =Product.find(params[:id])
        if @product && @product.update(product_params)
            render json: { message: 'Product successfully updated.'}, status: 200
        else 
            render error: {error: 'Unable to create product'}, status: 400
        end
    end

    def destroy
        @product =Product.find(params[:id])
        if @product && @product.destory
            render json: { message: 'Product successfully deleted.'}, status: 200
        else 
            render error: {error: 'Unable to destroy product'}, status: 400
        end
    end

    private 
    def product_params
        params.require(:product).permit(:title, :description, :price, :quantity, :category_id, :store_id)
    end
end
