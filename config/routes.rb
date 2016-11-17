Rails.application.routes.draw do
  post "/rate" => "rater#create", as: :rate
  root "static_pages#home"
  get "/pages/:page" => "static_pages#show", as: :page

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks#create"}

  namespace :admin do
    resources :categories
    resources :places
  end

  resources :tours, only: [:index, :show] do
    resources :reviews
  end
  resources :places, only: :show
  resources :categories, only: :show

  resources :reviews do
    resources :likes, only: [:create, :destroy]
  end

  resources :comments do
    resources :likes, only: [:create, :destroy]
  end
end
