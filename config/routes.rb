Rails.application.routes.draw do
  root "home#index"

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :home, only: [:index,:show]
  # get '/home', to: 'home#index'
  get '/search', to: 'home#search'
  # get '/home/show/:id', to: 'home#show'
  # resources :products, except: :index
  resource :store
end