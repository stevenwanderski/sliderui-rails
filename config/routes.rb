Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  root 'home#index'

  get '/sliders/:short_code', to: 'sliders#show'

  constraints subdomain: 'app' do
    get '/sliders/:short_code', to: 'sliders#show'
  end

  namespace :admin do
    resources :sliders, only: [:index] do
      resources :slides, only: [:index]
    end
  end

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
    post '/user/confirm', to: 'user#confirm'

    post '/registrations', to: 'registrations#create'
    post '/registrations/temp', to: 'registrations#create_temp'
    post '/sessions', to: 'sessions#create'
    put '/sessions', to: 'sessions#update'
  end

  namespace :dashboard do
    resources :sliders do
      get '/embed', action: :embed
    end

    resource :account, only: [:edit, :update], controller: 'account'
  end
end
