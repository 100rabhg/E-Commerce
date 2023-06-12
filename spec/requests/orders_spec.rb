require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  describe 'GET index' do
    context 'if merchent is login' do
      before(:each) do
        @user = FactoryBot.create(:user, :merchant)
        sign_in @user
      end
      it 'return a successful responce' do
        get orders_path
        expect(response).to have_http_status(200)
      end
    end
    context 'if user is login' do
      before(:each) do
        @user = FactoryBot.create(:user, :merchant)
        sign_in @user
      end
      it 'return a successful responce' do
        get orders_path
        expect(response).to have_http_status(200)
      end
    end
    context 'not authenticated' do
      it 'redirected to' do
        get orders_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET show' do
    context 'if user authenticate' do
      before(:each) do
        @user = FactoryBot.create(:user, :customer)
        sign_in @user
      end
      it 'return a successful responce' do
        order = FactoryBot.create(:order, user: @user)
        get orders_path(order)
        expect(response).to have_http_status(200)
      end
    end
    context 'not authenticated' do
      it 'redirected to' do
        get '/orders/12'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET new' do
    context 'if user authenticate' do
      before(:each) do
        @user = FactoryBot.create(:user, :customer)
        sign_in @user
      end
      it 'return a successful responce' do
        category = FactoryBot.create(:category)
        store = FactoryBot.create(:store, user: @user)
        product = FactoryBot.create(:product, category:, store:)
        get new_order_path, params: { product_id: product.id }
        expect(response).to have_http_status(200)
      end
    end
    context 'not authenticated' do
      it 'redirected to' do
        get new_order_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST create' do
    context 'if user authenticate' do
      before(:each) do
        @user = FactoryBot.create(:user, :customer)
        sign_in @user
      end
      it 'return a successful responce' do
        category = FactoryBot.create(:category)
        store = FactoryBot.create(:store, user: @user)
        product = FactoryBot.create(:product, category:, store:)
        expect do
          post orders_path,
               params: { order: { product_id: product.id, quantity: 1, mobile_number: '1234567890', address: 'asdf',
                                  pincode: '123456', state: 'asdf', payment: :COD } }
        end.to change(Order, :count)
      end
    end
    context 'not authenticated' do
      it 'redirected to' do
        post orders_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PUT update' do
    context 'if user authenticate' do
      before(:each) do
        @user = FactoryBot.create(:user, :customer)
        sign_in @user
      end
      it 'return a successful responce' do
        order = FactoryBot.create(:order, user: @user)
        put order_path(order), params: { order: { status: :cancelled } }
        expect(response).to redirect_to(orders_path)
      end
    end
    context 'not authenticated' do
      it 'redirected to' do
        put '/orders/12'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'delete destroy' do
    context 'if user authenticate' do
      before(:each) do
        @user = FactoryBot.create(:user, :customer)
        sign_in @user
      end
      it 'return a successful responce' do
        order = FactoryBot.create(:order, user: @user)
        delete order_path(order)
        expect(response).to redirect_to(orders_path)
      end
    end
    context 'not authenticated' do
      it 'redirected to' do
        delete '/orders/12'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
