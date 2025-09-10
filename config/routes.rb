Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  resources :profiles

  resources :buildings, only: [:new, :create, :index]

  get "about", to: "pages#about", as: :about

  get "contact", to: "pages#contact", as: :contact

  get "leaderboard", to: "leaderboards#index"

  root to: "pages#home"
end
