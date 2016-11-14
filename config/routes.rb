Rails.application.routes.draw do
  root 'home#index'

  resources :sliders, only: [:show]

  namespace :api do
    resources :sliders, only: [:show, :create, :update] do
      member do
        get '/slides', action: 'slides'
        put '/:temp_user_id/claim', action: 'claim'
      end
    end

    resources :slides, only: [:create, :update, :destroy] do
      collection do
        put '/collection', action: :update_collection
      end
    end

    resources :user_sliders, only: [:index]

    get '/user', to: 'user#show'
    put '/user', to: 'user#update'

    post '/register', to: 'registrations#create'
    post '/register-temp', to: 'registrations#create_temp'
    post '/login', to: 'sessions#create'
  end
end
