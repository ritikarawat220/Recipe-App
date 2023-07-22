Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  
  resources :inventories do
    resources :inventory_foods, only: [:new, :create, :destroy]
  end

  resources :recipes do
    resources :recipe_foods, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :foods do
    resources :recipe_foods, only: [:new, :create, :destroy]
  end

  get 'shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'

  resources :recipe_food, only: [:index, :show, :edit, :update, :destroy]
  resources :public_recipes, only: %i[index show]
  
  resources :shopping_list, only: [:index, :show]
  resources :general_shopping_list, only: [:index, :show]

end