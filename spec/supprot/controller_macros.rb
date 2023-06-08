module ControllerMacros
    def login_user(user_type)
        before(:each) do 
            @request.env['devise.mapping'] = Devise.mapping[:user]
            user = FactoryBot.create(:user, user_type)
            sign_in user
        end
    end
end