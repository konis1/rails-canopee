Rails.application.routes.draw do
  # Les quatre lignes suivantes servent à créer un endpoint 'sidekiq' pour afficher l'interface web de la gem.
  # Mieux vaut les supprimer une fois l'app déployable, je pense.
  require "sidekiq/web"
  RailsCanopee::Application.routes.draw do
    mount Sidekiq::Web => '/sidekiq'
  end
require 'sidekiq/cron/web'

  authenticated :user, ->(user) { user.admin? } do

    get "admin", to: "pages#admin"
    resources :gardens do
      resources :garden_plants, only: %i[new create update destroy]
    end
  end

  authenticated :user, ->(user) { user.vip? } do
    get "vip", to: "pages#vip"
    resources :gardens
    resources :tasks
  end

  devise_for :users

  root to: "pages#home"
  resources :pages, only: %i[home merci]

  resources :gardens do
    resources :garden_plants, only: [:create, :destroy] do
    end
  end

  resources :plants, only: [] do
    resources :reviews, only: %i[new create]
  end

  resources :tasks, only: [:index] do
    member do
      patch :update_done
      patch :update_tasks
    end
  end

  # resources :payments, only: [:new, :create]
  resources :garden_plants, only: %i[show destroy update]
  resources :tasks, only: [:update]
  resources :pages, only: %i[home cover]

  # Cette route sert à prévenir l'utilisateur que sa région n'est pas supportée par l'app en ce moment.
  get "gardens/:id/unsupported_region", to: "gardens#unsupported_region", as: :unsupported_region

  post "gardens/:id/validate_plants", to: "gardens#validate_plants", as: :validate_plants_garden
  get "gardens/:id/select_plants", to: "gardens#select_plants", as: :select_plants
  get "gardens/:id/crush", to: "gardens#crush", as: :crush

  # Ces routes sont utilisées après la validation des crushes afin de demander les infos de livraison et le code d'achat
  # de l'utilisateur.
  get "users/:id/delivery_info", to: "registrations#edit_delivery_info", as: :edit_delivery_info
  patch "users/:id", to: "registrations#update_delivery_info", as: :update_delivery_info

  # Cette route envoie l'utilisateur sur une page de remerciement après avoir pris ses coordonnées.
  get "users/:id/merci", to: "pages#merci", as: :merci
end
