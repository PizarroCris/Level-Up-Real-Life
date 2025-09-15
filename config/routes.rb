Rails.application.routes.draw do
  get 'global_messages/create'
  devise_for :users

  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :profiles

  resources :buildings, only: [:new, :create, :show, :edit, :update] do
    resources :troops, only: [:new, :create, :index]
    resource :mine,    only: [:show], controller: 'resources', defaults: { kind: 'mine' }
    resource :sawmill, only: [:show], controller: 'resources', defaults: { kind: 'sawmill' }
    resource :quarry,  only: [:show], controller: 'resources', defaults: { kind: 'quarry' }
    
    member do
      patch :upgrade
    end
  end

  resources :guilds do
    member do
      post :join
      delete :leave
    end
    resources :guild_memberships, only: [:destroy], as: :memberships
  end
  
  resources :global_messages, only: [:create]
  resources :shop, only: [:show]
  resources :shop_equipment_items, only: [:create]

  get "about", to: "pages#about", as: :about
  get "contact", to: "pages#contact", as: :contact
  post "contact", to: "pages#submit_contact"
  get "settings", to: "pages#settings"
  get "leaderboard", to: "leaderboards#index"
  get "/base", to: "bases#show", as: :user_base
end
