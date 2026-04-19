Rails.application.routes.draw do
  # Static Pages
  root "static_pages#home"
  get "/home", to: "static_pages#home", as: "home"
  get "/about", to: "static_pages#about", as: "about"
  get "/edit_password", to: "users#edit_password", as: "edit_password"
  post "/update_password", to: "users#update_password", as: "update_password"
  patch "/update_profile", to: "users#update_profile", as: "update_profile"

  get "/login",  to: "sessions#new",  as: "login"
  get "/signup", to: "users#new",     as: "signup"
  delete "/logout", to: "sessions#destroy", as: "logout"
  get "/bio", to: "users#show", as: "show"
  get "/edit_profile", to: "users#edit_profile", as: "edit_profile"

  post "/users",    to: "users#create"
  post "/sessions", to: "sessions#create"
end

# Example of possible trips routes
# get    '/trips',          to: 'trips#index',   as: 'trips'
# get    '/trips/new',      to: 'trips#new',     as: 'new_trip'
# post   '/trips',          to: 'trips#create'
# get    '/trips/:id',      to: 'trips#show',    as: 'trip'
# get    '/trips/:id/edit', to: 'trips#edit',    as: 'edit_trip'
# patch  '/trips/:id',      to: 'trips#update'
# delete '/trips/:id',      to: 'trips#destroy'
