Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :inventories do
    resources :inventory_foods, only: [:new, :create, :destroy]
  end

  resources :foods do
    resources :recipe_foods, only: [:new, :create, :destroy]
  end

end