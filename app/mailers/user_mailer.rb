class UserMailer < ApplicationMailer
    def welcome_mail(user)
        @user = user
        mail(to: AdminUser.pluck(:email),subject:'new User Register to E-commerce')
    end
end