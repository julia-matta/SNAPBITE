Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  get "timeline", to: "pages#timeline", as: :timeline
  get "explore",  to: "pages#explore",  as: :explore
  get "profile",  to: "pages#profile",  as: :profile
  get "publish",  to: "ratings#new",   as: :publish

  resources :users, only: %i[show edit update]

  resources :restaurants do
    resources :ratings, only: %i[index]
  end

  resources :ratings, only: %i[new create destroy]

  resources :users do
    member do
      get :followers
      get :following
      get :friends
      get :categories
    end
  end
end
