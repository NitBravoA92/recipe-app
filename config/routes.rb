Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  # Defines the route for the "foods" page ("/foods")
  resources :foods, only: [:index, :new, :create, :destroy]
end
