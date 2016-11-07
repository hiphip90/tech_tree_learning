Rails.application.routes.draw do
  root 'dashboard#index'

  resources :trees, only: [:show] do
    resources :nodes, only: [:create]
  end
end
