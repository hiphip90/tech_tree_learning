Rails.application.routes.draw do
  root 'trees#index'

  resources :trees, only: [:index, :show, :edit] do
    resources :nodes, only: [:create]
  end
end
