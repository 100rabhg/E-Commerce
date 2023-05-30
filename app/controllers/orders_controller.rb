class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = current_user.order
  end

  def show
      @order = current_user.order.find(params[:id])
      @orderItems = @order.orderItem
  end

  def new
    Product.find(params[:product_id])
    @order =  Order.new
    @product_id = params[:product_id]
  end

  def create
    total_sum = Product.find(params[:order][:product_id]).price
    @order  = Order.new(order_params.merge(total_price:total_sum, user:current_user))
    if @order.save
        unless OrderItem.create(product_id:params[:order][:product_id], order: @order)
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

  private
  def order_params
    params.require(:order).permit(:mobile_number, :address, :pincode,:state, )
  end
end
