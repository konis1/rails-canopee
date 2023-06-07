Rails.application.routes.draw do
  devise_for :users
  root to: "gardens#index"
  resources :gardens do
    resources :garden_plants, only: [:create] do
      resources :tasks, only: [:index]
    end
  end

  resources :plants, only: [] do
    resources :reviews, only: [:new, :create]
  end

  resources :garden_plants, only: [:show, :destroy, :update]
  resources :tasks, only: [:update]
end
