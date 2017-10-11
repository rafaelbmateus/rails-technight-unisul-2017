Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'tickets#index'
  devise_for :users
  resources :tickets
  resources :statuses
  resources :users
end
