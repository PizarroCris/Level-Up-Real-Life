Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  resources :profiles

  get "about", to: "pages#about", as: :about

  root to: "devise/sessions#new"
end
