Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions:       'admins/sessions',
    passwords:      'admins/passwords',
    registrations:  'admins/registrations'
  }
  devise_for :users, controllers: {
    sessions:       'users/sessions',
    passwords:      'users/passwords',
    registrations:  'users/registrations'
  }
  root to: 'questions#index'
  resources :questions do
    post :confirm, action: :confirm_new, on: :new
    get :search_results, on: :collection
  end
end
