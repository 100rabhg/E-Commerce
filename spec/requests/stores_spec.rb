require 'rails_helper'

RSpec.describe 'Store', type: :request do
  describe 'GET show' do
    context 'when user is authenticated' do
      before(:each) do
        @user = FactoryBot.create(:user, :merchant)
        sign_in @user
      end
      it 'return a successful responce' do
        FactoryBot.create(:store, user: @user)
        get store_path
        expect(response).to have_http_status(200)
      end
      it 'return a successful responce' do
        get store_path
        expect(response).to have_http_status(302)
      end
    end

    context 'when user is not authenticated' do
      it 'it redirected to ther login page' do
        get store_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET edit' do
    context 'when user is authenticated' do
      before(:each) do
        @user = FactoryBot.create(:user, :merchant)
        sign_in @user
      end
      it 'should have store' do
        FactoryBot.create(:store, user: @user)
        get edit_store_path
        expect(response).to have_http_status(200)
      end
      it 'if not have store' do
        get edit_store_path
        expect(response).to have_http_status(302)
      end
    end

    context 'when user is not authenticated' do
      it 'it redirected to ther login page' do
        get edit_store_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET new' do
    context 'when user is authenticated' do
      before(:each) do
        @user = FactoryBot.create(:user, :merchant)
        sign_in @user
      end
      it 'should not have store' do
        get new_store_path
        expect(response).to have_http_status(200)
      end
      it 'if have store' do
        FactoryBot.create(:store, user: @user)
        get new_store_path
        expect(response).to have_http_status(302)
      end
    end

    context 'when user is not authenticated' do
      it 'it redirected to ther login page' do
        get new_store_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'post create' do
    context 'when user is authenticated' do
      before(:each) do
        @user = FactoryBot.create(:user, :merchant)
        sign_in @user
      end
      it 'should not have store' do
        post store_path, params: { store: { name: Faker::Name.unique.name } }
        expect(response).to redirect_to(store_path)
      end
      it 'if have store' do
        FactoryBot.create(:store, user: @user)
        post store_path, params: { store: { name: Faker::Name.unique.name } }
        expect(response).to redirect_to(store_path)
      end
    end

    context 'when user is not authenticated' do
      it 'it redirected to ther login page' do
        post store_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'put update' do
    context 'when user is authenticated' do
      before(:each) do
        @user = FactoryBot.create(:user, :merchant)
        sign_in @user
      end
      it 'should have store' do
        FactoryBot.create(:store, user: @user)
        put store_path, params: { store: { name: Faker::Name.unique.name } }
        expect(response).to redirect_to(store_path)
      end
      it 'if not have store' do
        put store_path, params: { store: { name: Faker::Name.unique.name } }
        expect(response).to redirect_to(new_store_path)
      end
    end

    context 'when user is not authenticated' do
      it 'it redirected to ther login page' do
        put store_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
