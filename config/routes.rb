Rails.application.routes.draw do
  root 'dashboard#index'

  resources :trees, only: [:show]
end
