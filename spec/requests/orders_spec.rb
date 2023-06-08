require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "GET index" do
    context "if merchent is login" do
      before(:each) do
        @user = FactoryBot.create(:user, :merchant)
        sign_in @user
      end
      it "return a successful responce" do
        get orders_path
        expect(response).to have_http_status(200)
      end
    end
    context "if user is login" do
      before(:each) do
        @user = FactoryBot.create(:user, :merchant)
        sign_in @user
      end
      it "return a successful responce" do
        get orders_path
        expect(response).to have_http_status(200)
      end
    end
    context "not authenticated" do
      it "redirected to" do
        get orders_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
  
  describe "GET show" do
    context "if user suthenticate" do
      before(:each) do
        @user = FactoryBot.create(:user, :customer)
        sign_in @user
      end
      it "return a successful responce" do
        order = FactoryBot.create(:order, user: @user)
        get orders_path(order)
        expect(response).to have_http_status(200)
      end
    end
    context "not authenticated" do
      it "redirected to" do
        get '/orders/12'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
