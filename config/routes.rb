Rails.application.routes.draw do
  devise_for :admins

  # devise_for :users, controllers: {
  #   registrations: 'registrations'
  # }

  root 'pages#home'
  get '/privacy', to: 'pages#privacy'
  get '/terms', to: 'pages#terms'

  get '/sliders/:short_code', to: 'sliders#show'

  namespace :admin do
    resources :sliders, only: [:index, :show]
    resources :request_logs, only: [:index]
    resources :track_logs, only: [:index]
    resources :users, only: [:index] do
      member do
        get 'send_expired_outreach', action: :send_expired_outreach
      end
    end
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

    get '/sliders/:short_code/slides/new', to: 'sliders/slides#new', as: :sliders_slide_new
    post '/sliders/:short_code/slides', to: 'sliders/slides#create', as: :sliders_slide
    get '/sliders/:short_code/slides/:id', to: 'sliders/slides#edit', as: :sliders_slide_edit
    patch '/sliders/:short_code/slides/:id', to: 'sliders/slides#update', as: :sliders_slide_update

    get '/subscription/checkout', to: 'subscription#checkout', as: :subscription_checkout
    get '/subscription/success', to: 'subscription#success', as: :subscription_success

    resource :account, only: [:show, :update], controller: 'account'
  end

  post '/track', to: 'track#create'
  get '/unsubscribe/:user_id', to: 'unsubscriptions#create', as: :unsubscribe
  get '/unsubscribe/:user_id/success', to: 'unsubscriptions#show', as: :unsubscribe_success

  match '*unmatched', to: 'application#not_found_method', via: :all
end
