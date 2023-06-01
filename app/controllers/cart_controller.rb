class CartController < ApplicationController
  include OrderMethod

  before_action :authenticate_user!

  def index
    # byebug
    @cartItems = current_user.cartItems
    return unless @cartItems.instance_of?(CartItem)

    authorize! :manage, @cartItems
  end

  def create
    @cartItem = CartItem.new(cart_params)
    authorize! :manage, @cartItem
    @cartItem.save if product_not_in_cart?
    redirect_to cart_index_path
  end

  def update
    @cartItem = CartItem.find(params[:id])
    authorize! :manage, @cartItem
    if @cartItem.product.quantity >= params[:quantity].to_i && params[:quantity].to_i.positive?
      @cartItem.update(update_quantity)
    end
    redirect_to cart_index_path
  end

  def destroy
    @cartItem = CartItem.find(params[:id])
    authorize! :manage, @cartItem
    @cartItem.destroy
    redirect_to cart_index_path, status: :see_other
  end

  def order
    cartItems = current_user.cartItems
    @total_sum = cartItems.pluck(:sub_total).inject(:+)
    order_now(params)
    if @order.save
      cartItems.each do |cartItem|
        return unless create_order_item(@order, cartItem.product_id, cartItem.quantity)

        cartItem.destroy
      end
      redirect_to order_path(@order)
    else
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  private

  def product_not_in_cart?
    CartItem.where(user_id: current_user.id, product_id: params[:product_id]).count.zero?
  end

  def cart_params
    params.permit(:product_id).merge!(user_id: current_user.id, quantity: 1)
  end

  def update_quantity
    params.permit(:quantity)
  end
end
