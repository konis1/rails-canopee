Rails.application.routes.draw do
  require "sidekiq/web"
  # authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  # end

  devise_for :users

  root to: "pages#home"
  resources :gardens do
    resources :garden_plants, only: [:create] do
    end
  end

  resources :plants, only: [] do
    resources :reviews, only: [:new, :create]
  end

  resources :tasks, only: [:index] do
    # member do
    #   gardens/:id/
    # end
  end
  resources :garden_plants, only: [:show, :destroy, :update]
  resources :tasks, only: [:update]

  post "gardens/:id/validate_plants", to: "gardens#validate_plants", as: :validate_plants_garden
  get "gardens/:id/select_plants", to: "gardens#select_plants", as: :select_plants
end
