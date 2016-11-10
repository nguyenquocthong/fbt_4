Rails.application.routes.draw do
  root "static_pages#home"
  get "/pages/:page" => "static_pages#show", as: :page
end
