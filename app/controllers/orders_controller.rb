class OrdersController < ApplicationController
  include OrderMethod

  before_action :authenticate_user!

  def index
    if current_user.merchant?
      @orderItems = OrderItem.merchant_order_item(current_user.id)
      authorize! :read, @orderItem if @orderItem.instance_of?(OrderItem)
    else
      @orders = current_user.orders
      authorize! :read, @orders if @orders.instance_of?(Order)
    end
  end

  def show
    @order = Order.find(params[:id])
    authorize! :read, @order
    @orderItems = @order.orderItems
  end

  def new
    @order = Order.new
    authorize! :manage, @order
    if params[:method].present?
      @method = true
    else
      product = Product.find(params[:product_id])
      @product_id = params[:product_id]
      if params[:quantity].present? && product.quantity >= params[:quantity].to_i && params[:quantity].to_i.positive?
        @quantity = params[:quantity].to_i
      else
        @quantity = 1
      end
    end
  end

  def create
    @total_sum = Product.find(params[:order][:product_id]).price * params[:order][:quantity].to_i
    order_now(params)
    if @order.save!
      create_order_item(@order, params[:order][:product_id], params[:order][:quantity].to_i)
      redirect_to order_path(@order)
    else
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  def update
    order = Order.find(params[:id])
    authorize! :update, order
    if order.update(update_params)
      redirect_to orders_path
    else
      redirect_to orders_path, status: :unprocessable_entity
    end
  end

  def destroy
    order = Order.find(params[:id])
    authorize! :manage, order
    order.update(status: :cancelled)
    redirect_to orders_path
  end

  private

  def update_params
    params.require(:order).permit(:status)
  end
end
