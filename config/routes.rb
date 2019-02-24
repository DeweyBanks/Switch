Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end
  root 'home#index'
  resources :listings
  get '/connect', to: 'registration#connect', as: 'smart'
  get '/oauth/callback', to: 'registration#callback'
  get '/getswitch', to: 'registration#switch'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
