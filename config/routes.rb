Rails.application.routes.draw do
  root "pages#home"

  get "/login",  to: "sessions#new",  as: "login"
  get "/signup", to: "users#new",     as: "signup"
  delete "/logout", to: "sessions#destroy", as: "logout"

  post "/users",    to: "users#create"
  post "/sessions", to: "sessions#create"
end