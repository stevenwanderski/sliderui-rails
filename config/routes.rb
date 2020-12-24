Rails.application.routes.draw do
  devise_for :admins

  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  root 'pages#home'
  get '/privacy', to: 'pages#privacy'
  get '/terms', to: 'pages#terms'

  get '/sliders/:short_code', to: 'sliders#show'
  post '/webhooks/stripe', to: 'webhooks#stripe'

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

    post '/stripe/checkout', to: 'stripe#checkout'
    post '/stripe/portal', to: 'stripe#portal'
  end

  namespace :dashboard do
    resources :sliders do
      get '/embed', action: :embed
    end

    get '/pricing', to: 'pricing#index'
    post '/pricing', to: 'pricing#create'

    resource :password, only: [:edit, :update], controller: 'password'
    resource :subscription, only: [:edit, :update], controller: 'subscription' do
      get '/success', action: 'success'
    end
  end
end
