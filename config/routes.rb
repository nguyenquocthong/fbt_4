Rails.application.routes.draw do
  post "/rate" => "rater#create", as: :rate
  root "static_pages#home"
  get "/pages/:page" => "static_pages#show", as: :page

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks#create"}

  namespace :admin do
    resources :categories
    resources :places
    resources :bookings, only: [:index, :show, :update]
  end

  resources :tours, only: [:index, :show] do
    resources :reviews
  end

  resources :places, only: :show
  resources :categories, only: :show

  resources :reviews do
    resources :likes, only: [:create, :destroy]
  end

  resources :comments, except: [:show, :new] do
    resources :likes, only: [:create, :destroy]
  end
  resources :bookings, only: [:new, :create]

  get "payments/new", to: "payments#new"
  get "payments/update", to: "payments#update"
  get "/comments/new/(:parent_id)", to: "comments#new", as: :new_comment
end
