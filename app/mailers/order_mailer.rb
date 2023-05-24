class OrderMailer < ApplicationMailer
    def send_status_mail(order)
        @order = order
        @user = order.user
        mail(to: @user.email,subject:"Your order has been #{@order.status}")
    end
end