Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  root to: 'questions#index'
  resources :questions do
    post :confirm, action: :confirm_new, on: :new
    get :search_results, on: :collection
  end
end
