class OrderMailer < ApplicationMailer
  def send_status_mail(order)
    @order = order
    @user = order.user
    mail(to: @user.email, subject: "Your order has been #{@order.status}")
  end

  def send_order_receive_mail(item)
    @item = item
    @user =  item.product.store.user
    mail(to: @user.email, subject: 'Order Received')
  end
end
