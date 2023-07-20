Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  
  resources :inventories do
    resources :inventory_foods, only: [:new, :create, :destroy]
  end

  resources :foods do
    resources :recipe_foods, only: [:new, :create, :destroy]
  end

end