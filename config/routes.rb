Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "posts#index"

  resources :posts
  resource :session, only: [:new, :create, :destroy] do
    get :logout, on: :collection, action: :destroy
  end
  post :signup, to: "users#create"

  resources :users, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
end
