Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :gardens do
    resources :garden_plants, only: [:create]
    resources :tasks, only: [:index]
  end
  resources :wishlists, only: [:show] do
    resources :wishlist_plants, only: [:create]
  end
  resources :plants, only: [] do
    resources :reviews, only: [:new, :create]
  end
  resources :wishlist_plants, only: [:destroy]
  resources :garden_plants, only: [:show, :destroy, :update]
  resources :tasks, only: [:update]
end
