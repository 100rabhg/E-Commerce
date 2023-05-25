class StoresController < ApplicationController

    before_action :check_user_is_login
    before_action :ensure_user_have_not_store, only: [:new,:create]
    before_action :ensure_user_have_store,  only: [:destory,:edit,:update,:show]

    def new
        @store = Store.new
    end

    def show
        @store = current_user.store
    end

    def create
        @store = Store.new(store_params)
        
        if current_user.store = @store
            redirect_to store_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @store = current_user.store
    end
    
    def update
        @store = current_user.store
        if @store.update(store_params)
            redirect_to store_path
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy

        current_user.store.destroy
        redirect_to root_path, status: :see_other
        
    end


    private
    def check_user_is_login
        unless user_signed_in?
            redirect_to new_user_session_path
        end
    end

    def ensure_user_have_not_store
        if current_user.store
            redirect_to store_path
        end
    end

    def ensure_user_have_store
        unless current_user.store
            redirect_to new_store_path
        end
    end

    def store_params
        params.require(:store).permit(:name, :description)
    end
end