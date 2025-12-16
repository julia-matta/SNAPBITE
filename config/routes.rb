Rails.application.routes.draw do
  devise_for :users

  # Use devise_scope para definir a rota raiz especificamente para o mapeamento 'user'
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  # get "timeline", to: "pages#timeline", as: :user_root

  # root to: "pages#home"

  get "timeline", to: "pages#timeline", as: :timeline
  get "explore",  to: "pages#explore",  as: :explore
  get "profile",  to: "pages#profile",  as: :profile
  get "publish",  to: "ratings#new",    as: :publish

  resources :users, only: %i[show edit update]

  resources :restaurants do
    resources :checkins, only: [:create]   # <<< NOVA ROTA DE CHECK-IN
    resources :ratings,  only: %i[index]
  end

  resources :ratings, only: %i[new create destroy]

  resources :users, only: %i[index show edit update] do
    member do
      get :followers
      get :following
      get :publications
    end
  end

  resources :friendships, only: %i[create destroy]


  resources :posts, only: [:new, :create, :show, :destroy] do
    resources :comments, only: :create
  end
end
