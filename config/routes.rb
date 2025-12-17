Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  # PÁGINAS
  get "timeline", to: "pages#timeline", as: :timeline
  get "explore",  to: "pages#explore",  as: :explore
  get "profile",  to: "pages#profile",  as: :profile
  get "publish",  to: "ratings#new",    as: :publish

  # USUÁRIOS
  resources :users, only: %i[index show edit update] do
    member do
      get :followers
      get :following
      get :publications
    end
  end

  # RESTAURANTES
  resources :restaurants do
    resources :checkins, only: [:create]
    resources :ratings,  only: [:index]
  end

  # AVALIAÇÕES
  resources :ratings, only: %i[new create destroy]

  # POSTS
  resources :posts, only: %i[new create show destroy] do
    resources :comments, only: [:create]
  end

  # AMIZADES
  resources :friendships, only: %i[create destroy]

  # =========================
  # 🤖 CHAT DA IA (IMPORTANTE)
  # =========================
  resources :chats, only: [:show]
  post "chats/:id/message", to: "chats#message"
end
