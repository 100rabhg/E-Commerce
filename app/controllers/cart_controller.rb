class CartController < ApplicationController
  def index
    @cartItems = current_user.cartItem
  end

  def create
    @item = CartItem.new(cart_params)
    @item.save if CartItem.where(user_id: current_user.id, product_id: params[:product_id]).count.zero?
    redirect_to cart_index_path
  end

  def update
    @item = current_user.cartItem.find(params[:id])
    if @item.product.quantity >= params[:quantity].to_i && params[:quantity].to_i.positive?
      @item.update(update_quantity)
    end
    redirect_to cart_index_path
  end

  def destroy
    current_user.cartItem.find(params[:id]).destroy
    redirect_to cart_index_path, status: :see_other
  end

  private

  def cart_params
    params.permit(:product_id).merge!(user_id: current_user.id)
  end

  def update_quantity
    params.permit(:quantity)
  end
end
