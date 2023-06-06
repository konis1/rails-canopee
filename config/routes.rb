Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :gardens do
    resources :garden_plants, only: [:create]
    resources :tasks, only: [:index]
  end

  resources :plants, only: [] do
    resources :reviews, only: [:new, :create]
  end
  
  resources :garden_plants, only: [:show, :destroy, :update]
  resources :tasks, only: [:update]
end
