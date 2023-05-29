class OrdersController < ApplicationController
  
  def index
    @orders = current_user.order
  end

  def show
      @order = current_user.order.find(params[:id])
      @orderItems = @order.orderItem
  end

  def create
    # byebug
    total_sum = Product.find(params[:product_id]).price
    @order  = Order.new(total_price:total_sum,user: current_user)

    if @order.save
        unless OrderItem.create(product_id:params[:product_id], order: @order)
            @order.destroy
            redirect_to root_path, status: :unprocessable_entity
        end
      redirect_to order_path(@order)
    else
      redirect_to root_path,  status: :unprocessable_entity
    end

  end

  def destroy
      order = current_user.order.find(params[:id])
      order.update(status: :cancelled)
      redirect_to orders_path
  end

end
