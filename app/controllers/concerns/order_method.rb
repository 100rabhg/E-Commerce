module OrderMethod
  extend ActiveSupport::Concern

  def order_now(params)
    @order = Order.new(order_params(params))
    authorize! :manage, @order
  end

  def create_order_item(order, product_id, quantity)
    orderitem = OrderItem.new(product_id:, order:, quantity:)
    unless orderitem.save
      order.destroy
      redirect_to root_path, status: :unprocessable_entity
      return false
    end
    OrderMailer.send_order_receive_mail(orderitem).deliver_now
    true
  end

  private

  def order_params(params)
    params.require(:order).permit(:mobile_number, :address, :pincode, :state, :payment).merge(
      total_price: @total_sum, user: current_user
    )
  end
end
