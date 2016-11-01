Rails.application.routes.draw do
  root 'home#index'

  resources :sliders, only: [:show]

  namespace :api do
    resources :sliders, only: [:show, :create] do
      member do
        get '/slides', action: 'slides'
      end
    end

    resources :slides, only: [:create, :update, :destroy] do
      collection do
        put '/collection', action: :update_collection
      end
    end
  end
end
