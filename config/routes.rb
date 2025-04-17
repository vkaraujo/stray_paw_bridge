# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :users, only: [:index] do
      member do
        patch :toggle_admin
        patch :toggle_active
      end
    end

    get "/", to: "dashboard#index", as: :dashboard
  end

  resources :notifications, only: [] do
    member do
      patch :mark_as_read
    end
  end

  get "/dashboard", to: "dashboard#index", as: :dashboard

  resources :adoption_requests, only: [:create] do
    member do
      patch :approve
      patch :reject
      patch :cancel
    end
  end

  resources :pets, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  devise_for :users
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
