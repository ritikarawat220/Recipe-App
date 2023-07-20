Rails.application.routes.draw do
  devise_for :users
  # get 'home/index'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  authenticated :user do
    root 'recipes#index', as: :authenticated_root

    resources :foods, only: %i[index new create destroy]
    resources :recipes, only: %i[index show new create destroy update] do
      member do
        patch 'toggle'
      end
      resources :recipe_foods, only: %i[new create destroy]
    end

    resources :inventories, only: %i[index new create show destroy] do
      resources :inventory_foods, only: %i[new create destroy]
    end
  end

  get 'shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'

  resources :public_recipes, only: %i[index show]
  resources :general_shopping_list, only: [:index, :show]

end