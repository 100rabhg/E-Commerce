class CartController < ApplicationController
  before_action :authenticate_user!

  def index
    # byebug
    @cartItems = current_user.cartItem
    return unless @cartItems.instance_of?(CartItem)

    authorize! :manage, @cartItems
  end

  def create
    @item = CartItem.new(cart_params)
    authorize! :manage, @item
    @item.save if CartItem.where(user_id: current_user.id, product_id: params[:product_id]).count.zero?
    redirect_to cart_index_path
  end

  def update
    @item = current_user.cartItem.find(params[:id])
    authorize! :manage, @item
    if @item.product.quantity >= params[:quantity].to_i && params[:quantity].to_i.positive?
      @item.update(update_quantity)
    end
    redirect_to cart_index_path
  end

  def destroy
    @cartItem = current_user.cartItem.find(params[:id])
    authorize! :manage, cartItem
    @cartItem.destroy
    redirect_to cart_index_path, status: :see_other
  end

  def order
    items = current_user.cartItem
    total_sum = items.pluck(:sub_total).inject(:+)
    @order = Order.new(order_params.merge(total_price: total_sum, user: current_user))
    authorize! :manage, @order
    if @order.save
      items.each do |item|
        orderitem = OrderItem.new(product_id: item.product_id, order: @order, quantity: item.quantity)
        unless orderitem.save
          @order.destory
          return redirect_to root_path, status: :unprocessable_entity
        end
        OrderMailer.send_order_receive_mail(orderitem).deliver_now
        item.destroy
      end
      redirect_to order_path(@order)
    else
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  private

  def cart_params
    params.permit(:product_id).merge!(user_id: current_user.id)
  end

  def update_quantity
    params.permit(:quantity)
  end

  def order_params
    params.require(:order).permit(:mobile_number, :address, :pincode, :state, :payment)
  end
end
