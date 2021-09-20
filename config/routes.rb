Rails.application.routes.draw do
  root to: 'questions#index'
  resource :questions
end
