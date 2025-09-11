Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  resources :profiles

  resources :buildings, only: [:new, :create, :show] do
    resources :troops, only: [:new, :create, :index]
  end

  get "about", to: "pages#about", as: :about

  get "settings", to: "pages#settings"

  get "leaderboard", to: "leaderboards#index"

  get "/base", to: "bases#show", as: :user_base

  root to: "pages#home"
end
