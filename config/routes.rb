Rails.application.routes.draw do
  devise_for :admins

  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  root 'pages#home'
  get '/privacy', to: 'pages#privacy'
  get '/terms', to: 'pages#terms'

  get '/sliders/:short_code', to: 'sliders#show'

  namespace :admin do
    resources :sliders, only: [:index, :show]
    resources :request_logs, only: [:index]
    resources :track_logs, only: [:index]
    resources :users, only: [:index]
  end

  namespace :dashboard do
    get '/sliders/new', to: 'sliders#new', as: :new_slider
    get '/sliders/:short_code', to: 'sliders#edit', as: :edit_slider
    patch '/sliders/:short_code', to: 'sliders#update', as: :update_slider
    get '/sliders/:short_code/embed', to: 'sliders#embed', as: :embed_slider
    post '/sliders/:short_code/slide_create', to: 'sliders#slide_create', as: :slide_create
    get '/sliders/:short_code/slide_destroy/:slide_id', to: 'sliders#slide_destroy', as: :slide_destroy
    post '/sliders/:short_code/slides_update', to: 'sliders#slides_update', as: :slides_update

    # resource :account, only: [:show], controller: 'account'
    # resource :password, only: [:edit, :update], controller: 'password'
    # resource :subscription, only: [:edit, :update], controller: 'subscription' do
    #   get '/success', action: 'success'
    # end
  end

  post '/track', to: 'track#create'

  match '*unmatched', to: 'application#not_found_method', via: :all
end
