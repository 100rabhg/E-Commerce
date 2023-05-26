class OrdersController < ApplicationController

    def index
       @orders = current_user.order
    end

    def show
    end

    def create
    end

    def update
    end

    def destroy
    end
end
