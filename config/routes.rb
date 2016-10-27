Rails.application.routes.draw do
  root 'home#index'

  resources :sliders, only: [:show]

  namespace :api do
    resources :sliders, only: [:show, :create]
  end
end
