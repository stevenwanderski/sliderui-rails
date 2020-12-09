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

    resources :request_logs, only: [:index]
  end

  namespace :api do
    resources :sliders, only: [:show, :update]

    resources :slides, only: [:create, :destroy] do
      collection do
        put '/collection', action: :update_collection
      end
    end
  end

  namespace :dashboard do
    resources :sliders do
      get '/embed', action: :embed
    end

    resource :account, only: [:edit, :update], controller: 'account'
    resource :subscription, only: [:edit, :update], controller: 'subscription'
  end
end
