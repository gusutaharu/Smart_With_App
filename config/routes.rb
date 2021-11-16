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
  resources :questions do
    get :search_results, on: :collection
    resource :interests, only: [:create, :destroy]
  end
end
