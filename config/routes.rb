Rails.application.routes.draw do
  get '/stock', to: 'stock#index'
  resources :stock, only: [:update]
  
  root to: 'home#index'
  devise_for :users

  resource :cart, only: [:show, :destroy]

  resources :cart_items, only: [:create, :destroy] do
    member do
      post 'increase'
      post 'decrease'
    end
  end

  resources :products

  post "/checkout", to: "checkout#create", as: :checkout_stripe
  post "/checkout_mercado", to: "checkout_mercado#create", as: :checkout_mercado
  get "/success", to: "checkout#success"
  get "/cancel", to: "checkout#cancel"
  get "/success_mercado", to: "checkout_mercado#success"
  get "/cancel_mercado", to: "checkout_mercado#cancel"
  get "/orders", to: "orders#index", as: :orders
  post "/webhook", to: "webhooks#create"



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
