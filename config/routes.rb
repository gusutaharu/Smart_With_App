Rails.application.routes.draw do
  root to: 'questions#index'
  resources :questions do
    post :confirm, action: :confirm_new, on: :new
    get :search_results, on: :collection
  end
end
