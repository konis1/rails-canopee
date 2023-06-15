Rails.application.routes.draw do
  require "sidekiq/web"
  # authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  # end

  devise_for :users

  root to: "pages#home"
  resources :pages, only: [:home, :merci]
  get'merci', to:'pages#merci'

  resources :gardens do
    resources :garden_plants, only: [:create, :destroy] do
    end
  end

  resources :plants, only: [] do
    resources :reviews, only: [:new, :create]
  end

  resources :tasks, only: [:index] do
    member do
      patch :update_done
      patch :update_tasks
    end
  end

  resources :garden_plants, only: [:show, :destroy, :update]
  resources :tasks, only: [:update]
  resources :pages, only: [:home, :cover]

  post "gardens/:id/validate_plants", to: "gardens#validate_plants", as: :validate_plants_garden
  get "gardens/:id/select_plants", to: "gardens#select_plants", as: :select_plants
  get "gardens/:id/crush", to: "gardens#crush", as: :crush


end
