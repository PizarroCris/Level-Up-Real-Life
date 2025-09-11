Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  resources :profiles

  resources :buildings, only: [:new, :create, :show]

  get "about", to: "pages#about", as: :about

  get "leaderboard", to: "leaderboards#index"

  get "/base", to: "bases#show", as: :user_base

  root to: "pages#home"
end
