class ProductsController < ApplicationController
  before_action :ensure_user_have_store

  def new
    @product = Product.new
  end

  def create
    param = product_params
    param[:store_id] = current_user.store.id
    @product = Product.new(param)
    if @product.save
      redirect_to store_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = current_user.store.product.find(params[:id])
  end

  def update
    @product = current_user.store.product.find(params[:id])
    if @product.update(product_params)
      redirect_to store_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.store.product.find(params[:id]).destroy
    redirect_to store_path, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :quantity, :category_id)
  end

  def ensure_user_have_store
    return if current_user.store

    redirect_to new_store_path
  end
end
