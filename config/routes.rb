Rails.application.routes.draw do

  resources :authorization_codes, only:[:new, :create, :edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :balance_adjustments
    resources :platforms
    resources :withdrawals
    resources :assets
  end

  resources :orders
  resources :withdrawals
  resources :deposits
  resources :users

  resources :password_resets, only: [:new, :create, :edit, :update]

  post '/login'    => 'access_tokens#create'
  get '/login'     => 'authorization_codes#new'
  delete '/logout' => 'access_tokens#destroy'

  get 'balances', to: 'pages#balances'

  root to: 'pages#welcome'
end