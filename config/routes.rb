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

  namespace :admin do
    resources :sliders, only: [:index, :show]
    resources :request_logs, only: [:index]
    resources :track_logs, only: [:index]
    resources :users, only: [:index]
  end

  namespace :dashboard do
    get '/sliders', to: 'sliders#index'
    get '/sliders/new', to: 'sliders#new', as: :new_slider
    get '/sliders/:short_code', to: 'sliders#edit', as: :edit_slider
    patch '/sliders/:short_code', to: 'sliders#update', as: :update_slider
    delete '/sliders/:short_code', to: 'sliders#destroy', as: :destroy_slider

    post '/sliders/:short_code/slide_create', to: 'sliders#slide_create', as: :slide_create
    get '/sliders/:short_code/slide_destroy/:slide_id', to: 'sliders#slide_destroy', as: :slide_destroy
    post '/sliders/:short_code/slides_update', to: 'sliders#slides_update', as: :slides_update

    post '/sliders/:short_code/sign_up', to: 'sliders#user_create', as: :slider_user_create
    post '/sliders/:short_code/sign_in', to: 'sliders#session_create', as: :slider_session_create

    get '/subscription/checkout', to: 'subscription#checkout', as: :subscription_checkout
    get '/subscription/success', to: 'subscription#success', as: :subscription_success

    resource :account, only: [:show, :update], controller: 'account'
  end

  post '/track', to: 'track#create'

  match '*unmatched', to: 'application#not_found_method', via: :all
end
