require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'GET show' do
    context 'visit products show page' do
      user = FactoryBot.create(:user, role: :merchant)
      store = FactoryBot.create(:store, user:)
      category = FactoryBot.create(:category)
      @product = FactoryBot.create(:product, store:, category:)
      it 'return a successful responce' do
        get @product
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET new' do
    context 'when user is authenticate' do
      before(:each) do
        @user = FactoryBot.create(:user, :merchant)
        sign_in @user
      end
      it 'return a successful if have store' do
        FactoryBot.create(:store, user: @user)
        get new_product_path
        expect(response).to have_http_status(200)
      end
      it 'redirected to store create page' do
        get new_product_path
        expect(response).to redirect_to(new_store_path)
      end
    end

    context 'when user is not authenticated' do
      it 'it redirected to ther login page' do
        get new_product_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'post create' do
    context 'when user is authenticate' do
      before(:each) do
        @user = FactoryBot.create(:user, :merchant)
        sign_in @user
      end
      it 'return a successful if have store' do
        store = FactoryBot.create(:store, user: @user)
        category = FactoryBot.create(:category)
        post products_path,
             params: { product: { title: 'Product title', price: 10, quantity: 12, store:, category_id: category.id } }
        expect(response).to redirect_to(store_path)
      end
      it 'redirected to store create page' do
        post products_path
        expect(response).to redirect_to(new_store_path)
      end
    end

    context 'when user is not authenticated' do
      it 'it redirected to ther login page' do
        post products_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'put update' do
    context 'when user is authenticate' do
      before(:each) do
        @user = FactoryBot.create(:user, :merchant)
        sign_in @user
      end
      it 'return a successful if have store' do
        store = FactoryBot.create(:store, user: @user)
        category = FactoryBot.create(:category)
        product = FactoryBot.create(:product, store:, category:)
        put product_path product, params: { product: { description: 'description' } }
        expect(response).to redirect_to(store_path)
      end
    end
    context 'when user is not authenticated' do
      it 'it redirected to ther login page' do
        put '/products/12'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'delete update' do
    context 'when user is authenticate' do
      before(:each) do
        @user = FactoryBot.create(:user, :merchant)
        sign_in @user
      end
      it 'return a successful if have store' do
        store = FactoryBot.create(:store, user: @user)
        category = FactoryBot.create(:category)
        product = FactoryBot.create(:product, store:, category:)
        expect { delete product_path product }.to change(Product, :count)
      end
    end
    context 'when user is not authenticated' do
      it 'it redirected to ther login page' do
        delete '/products/12'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
