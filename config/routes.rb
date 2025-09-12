Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  resources :profiles

  resources :buildings, only: [:new, :create, :show, :edit, :update] do
    resources :troops, only: [:new, :create, :index]
    
    member do
      patch :upgrade
    end
  end

  get "about", to: "pages#about", as: :about
  get "contact", to: "pages#contact", as: :contact
  get "settings", to: "pages#settings"
  get "leaderboard", to: "leaderboards#index"
  get "/base", to: "bases#show", as: :user_base

  root to: "pages#home"
end
