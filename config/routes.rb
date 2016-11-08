Rails.application.routes.draw do
  root 'trees#index'

  resources :trees, only: [:show, :edit] do
    resources :nodes, only: [:create]
  end
end
