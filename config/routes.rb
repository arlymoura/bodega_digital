Rails.application.routes.draw do
  devise_for :members
  devise_for :users
  # devise_for :admins

  match '/404', to: 'system#not_found', via: :all
  match '/500', to: 'system#error', via: :all

  root 'admin/dashboards#index'

  namespace :admin do
    root to: 'dashboards#index'
    resources :dashboards, only: %i[index]
    resources :categories
    resources :products
    resources :stocks do
      resources :stock_items, only: %i[edit update], module: :stocks
    end

    resources :members
  end

  namespace :member do
    root to: 'dashboards#index'
    resources :dashboards, only: [:index]
    # resources :teams, only: [:show]
    # resources :players
    # resources :members
  end

  resources :dashboards, only: %i[index]
  resources :home, only: %i[index]
end
