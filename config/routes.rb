Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :carts, only: [:destroy] do
    member do
      get 'add_to_cart', to: 'carts#add_to_cart', as: 'add_to_cart'
    end

    collection do
      get 'view_cart', to: 'carts#view_cart', as: 'view_cart'
      get 'complete_order', to: 'carts#complete_order', as: 'complete_order'
      get 'delete_order', to: 'carts#delete_order', as: 'delete_order'
    end
  end
  resources :customers
  resources :products
  resources :categories
  resources :vendors
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root to: "welcome#index"
end
