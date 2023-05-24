Rails.application.routes.draw do
  root "home#index"

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resource :home
  post 'home/search', to: 'home#search'

end