require 'rails_helper'

RSpec.describe "Carts", type: :request do
  describe "GET index" do
    context "if user is login" do
      before(:each) do
        @user = FactoryBot.create(:user, :merchant)
        sign_in @user
      end
      it "return a successful responce" do
        get cart_index_path
        expect(response).to have_http_status(200)
      end
    end
    context "not authenticated" do
      it "redirected to" do
        get cart_index_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "post create" do
    context "if user is login" do
      before(:each) do
        @user = FactoryBot.create(:user, :customer)
        sign_in @user
      end
      it "return a successful responce" do
        category = FactoryBot.create(:category)
        store = FactoryBot.create(:store, user: @user)
        product = FactoryBot.create(:product, category: category, store: store)
        expect {post cart_index_path, params: {product_id: product.id}}.to change(CartItem, :count)
      end
    end
    context "not authenticated" do
      it "redirected to" do
        post cart_index_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe "put update" do
    context "if user is login" do
      before(:each) do
        @user = FactoryBot.create(:user, :customer)
        sign_in @user
      end
      it "return a successful responce" do
        category = FactoryBot.create(:category)
        store = FactoryBot.create(:store, user: @user)
        product = FactoryBot.create(:product, category: category, store: store)
        cartItem = FactoryBot.create(:cartItem, product: product, user: @user)
        put cart_path(cartItem), params: {quantity:2}
        expect(response).to redirect_to cart_index_path
      end
    end
    context "not authenticated" do
      it "redirected to" do
        put '/cart/12'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe "post create" do
    context "if user is login" do
      before(:each) do
        @user = FactoryBot.create(:user, :customer)
        sign_in @user
      end
      it "return a successful responce" do
        category = FactoryBot.create(:category)
        store = FactoryBot.create(:store, user: @user)
        product = FactoryBot.create(:product, category: category, store: store)
        cartItem = FactoryBot.create(:cartItem, product: product, user: @user)
        expect {delete cart_path(cartItem)}.to change(CartItem, :count)
      end
    end
    context "not authenticated" do
      it "redirected to" do
        delete '/cart/12'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "post order" do
    context "if user is login" do
      before(:each) do
        @user = FactoryBot.create(:user, :customer)
        sign_in @user
      end
      it "return a successful responce" do
        category = FactoryBot.create(:category)
        store = FactoryBot.create(:store, user: @user)
        product = FactoryBot.create(:product, category: category, store: store)
        cartItem = FactoryBot.create(:cartItem, product: product, user: @user)
        expect {post order_cart_index_path ,params:{ order:{mobile_number:"1234567890",address:"asdfv",pincode:"123456",state:"sxcfdx", payment: :COD }}}.to change(Order, :count)
      end
    end
    context "not authenticated" do
      it "redirected to" do
        post order_cart_index_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
