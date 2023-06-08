Rails.application.routes.draw do
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

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

  patch "garden/:id/validate_plants", to: "gardens#validate_plants"

end
