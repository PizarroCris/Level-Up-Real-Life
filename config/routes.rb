Rails.application.routes.draw do
  get 'resources/index'
  get 'resources/show'
  get 'resources/new'
  get 'resources/create'
  get 'resources/edit'
  get 'resources/update'
  get 'resources/destroy'
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  resources :profiles

  resources :buildings, only: [:new, :create, :show, :edit, :update] do
    resources :troops, only: [:new, :create, :index]
    resources :resources

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
