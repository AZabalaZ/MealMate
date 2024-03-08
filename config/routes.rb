Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :meals do
    member do
      post 'add_to_my_recipes'
      post 'add_to_favorites'
      post 'remove_from_favorites'
      delete 'remove_from_favorites', to: 'meals#remove_from_favorites'
    end
  end
  resources :recipes, only: [:index, :destroy]
  resources :ingredients do
    collection do
      get 'search'
    end
  end
  # get "foods", to: "meals#foods"
  get "/recipes", to: "recipes#index"
  get "/favorites", to: "meals#favorites"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
