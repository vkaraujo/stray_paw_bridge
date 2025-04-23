# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :admin do
    resources :pets, only: [:index] do
      member do
        patch :toggle_visibility
      end
    end

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

  resources :pets do
    patch :conclude_adoption, on: :member
  end

  devise_for :users
  root 'home#index'

  mount Sidekiq::Web => '/sidekiq'
  get 'up' => 'rails/health#show', as: :rails_health_check
end
