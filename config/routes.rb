Rails.application.routes.draw do
  root 'trees#index'

  resources :trees, only: [:index, :show, :edit] do
    resources :nodes, except: [:index, :edit, :new] do
      resources :learning_materials, only: [:destroy], shallow: true
    end
  end
end
