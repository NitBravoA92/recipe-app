Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  # Routes for the 'Recipes'
  resources :recipes, only: [:index, :new, :create, :show, :destroy] do
    patch 'update_status', on: :member

    # Routes for the 'Recipe Foods'
    resources :recipe_foods, only: [:new, :create, :edit, :update, :destroy]
  end

  # Defines the route for the "foods"
  resources :foods, only: [:index, :new, :create, :destroy]

  #Route for the 'Public Recipes' page
  get '/public_recipes', to: 'recipe_foods#index', as: 'public_recipes'

  # Route for the 'General shopping list' page
  get '/general_shopping_list', to: 'recipe_foods#general_shopping_list', as: 'general_shopping_list'
end
