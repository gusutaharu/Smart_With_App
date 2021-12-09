Rails.application.routes.draw do
  root to: 'questions#index'
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations',
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }
  resources :users, only: [:show]
  resources :categories, only: [:index] do
    collection do
      get :get_os
      get :get_condition
    end
  end
  resources :questions do
    collection do
      get :get_category_os, defaults: { format: 'json' }
      get :get_category_condition, defaults: { format: 'json' }
    end
    resource :interests, only: [:create, :destroy]
    resources :answers, only: [:create, :destroy]
  end
  resources :search, only: [:index]
end
