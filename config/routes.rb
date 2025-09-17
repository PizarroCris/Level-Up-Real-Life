Rails.application.routes.draw do
  get 'global_messages/create'
  devise_for :users

  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get "about", to: "pages#about", as: :about
  get "contact", to: "pages#contact", as: :contact
  post "contact", to: "pages#submit_contact"
  get "settings", to: "pages#settings"
  get "leaderboard", to: "leaderboards#index"
  get "leaderboard/guilds", to: "leaderboards#guilds", as: :guild_leaderboard
  get "/base", to: "bases#show", as: :user_base

  post '/webhooks', to: 'webhooks#receive'
  get "inventory", to: "pages#inventory", as: :user_inventory
end
