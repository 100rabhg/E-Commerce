class ProductsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :ensure_user_have_store, except: :show
  before_action :inc_product, only: %i[edit update destroy]

  def show
    return redirect_to store_path if !current_user.nil? && current_user.merchant?

    @product = Product.find_by(id: params[:id])
  end

  def new
    @product = Product.new
    authorize! :manage, @product
  end

  def create
    @product = Product.new(product_params.merge!(store: current_user.store))
    authorize! :manage, @product
    if @product.save
      redirect_to store_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to store_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to store_path, status: :see_other
  end

  private

  def inc_product
    @product = Product.find(params[:id])
    authorize! :manage, @product
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :quantity, :category_id, :image)
  end

  def ensure_user_have_store
    return if current_user.store

    redirect_to new_store_path
  end
end
