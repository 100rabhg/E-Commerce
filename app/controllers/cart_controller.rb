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

  def order
    items  = current_user.cartItem
    total_sum = items.pluck(:sub_total).inject(:+)
    @order = Order.new(total_price:total_sum, user:current_user)

    if @order.save!
      items.each do |item|
        orderitem = OrderItem.new(product_id:item.product_id, order:@order, quantity:item.quantity)
        unless orderitem.save
          @order.destory
          return redirect_to root_path, status: :unprocessable_entity
        end
        items.each{ |item|
          item.destroy
        }
        return redirect_to order_path(@order)
      end
    else
      redirect_to root_path,  status: :unprocessable_entity
    end
  end

  private

  def cart_params
    params.permit(:product_id).merge!(user_id: current_user.id)
  end

  def update_quantity
    params.permit(:quantity)
  end
end
