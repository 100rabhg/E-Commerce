Rails.application.routes.draw do

  root 'home#index'

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :home, only: %i[index show]
  get '/search', to: 'home#search'
  resource :store
  resources :products, except: %i[index show]
  resources :cart, except: %i[show new edit] do
    post 'order', on: :collection
  end
  resources :orders, except: %i[edit update]
end
