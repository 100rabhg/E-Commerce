class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.merchant?
      @orderItem = OrderItem.joins(:order, product: :store).where('stores.user_id = ?',
                                                                  current_user.id).where(order: Order.not_cancelled).order(:status)
      authorize! :read, @orderItem if @orderItem.instance_of?(OrderItem)
    else
      @orders = current_user.order
      authorize! :read, @orders if @orders.instance_of?(Order)
    end
  end

  def show
    @order = current_user.order.find(params[:id])
    authorize! :read, @order
    @orderItems = @order.orderItem
  end

  def new
    @order = Order.new
    authorize! :manage, @order
    if params[:method].present?
      @method = true
    else 
      product = Product.find(params[:product_id])
      @product_id = params[:product_id]
      if product.quantity >= params[:quantity].to_i
        @quantity = params[:quantity].present? ? params[:quantity].to_i : 1
      else 
        @quantity = 1
      end
    end
  end

  def create
    total_sum = Product.find(params[:order][:product_id]).price * params[:order][:quantity].to_i
    @order = Order.new(order_params.merge(total_price: total_sum, user: current_user))
    authorize! :manage, @order
    if @order.save
      orderItem = OrderItem.new(product_id: params[:order][:product_id], order: @order, quantity:params[:order][:quantity])
      unless orderItem.save
        @order.destroy
        redirect_to root_path, status: :unprocessable_entity
      end
      OrderMailer.send_order_receive_mail(orderItem).deliver_now
      redirect_to order_path(@order)
    else
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  def update
    # byebug
    order = Order.find(params[:id])
    authorize! :update, order
    if order.update(update_params)
      redirect_to orders_path
    else
      redirect_to orders_path, status: :unprocessable_entity
    end
  end

  def destroy
    order = current_user.order.find(params[:id])
    authorize! :manage, order
    order.update(status: :cancelled)
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:mobile_number, :address, :pincode, :state, :payment)
  end

  def update_params
    params.require(:order).permit(:status)
  end
end
