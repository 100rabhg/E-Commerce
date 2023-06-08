require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  root 'home#index'

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :home, only: :index
  get '/search', to: 'home#search'
  resource :store, except: %i[destory]
  resources :products, except: %i[index]
  resources :cart, except: %i[show new edit] do
    post 'order', on: :collection
  end
  resources :orders, except: %i[edit]
  
  namespace :api do
    resources :products, except: %i[new edit]
  end


end
