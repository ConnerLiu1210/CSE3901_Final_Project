Rails.application.routes.draw do
  # Static Pages
  root "static_pages#home"
  get  "/home",  to: "static_pages#home",  as: "home"
  get  "/about", to: "static_pages#about", as: "about"
  get  "/help",  to: "static_pages#help"
  get  "/link",  to: "static_pages#link"

  # Auth
  get    "/login",           to: "sessions#new",          as: "login"
  get    "/signup",          to: "users#new",             as: "signup"
  delete "/logout",          to: "sessions#destroy",      as: "logout"
  post   "/sessions",        to: "sessions#create"

  # Admin
  get "/admin", to: "admin#dashboard", as: "admin"


  # Users
  get    "users",          to: "users#index"
  get    "users/new",      to: "users#new",  as: "new_user"
  get    "users/:id",      to: "users#show", as: "user"
  post   "users",          to: "users#create"
  delete "users/:id",      to: "users#destroy"
  get    "users/:id/edit", to: "users#edit",  as: "edit_user"
  patch  "users/:id",      to: "users#update"

  # Profile
  get   "/bio",             to: "users#show",           as: "show"
  get   "/edit_profile",    to: "users#edit_profile",   as: "edit_profile"
  patch "/update_profile",  to: "users#update_profile", as: "update_profile"
  get   "/edit_password",   to: "users#edit_password",  as: "edit_password"
  post  "/update_password", to: "users#update_password", as: "update_password"

  # Trips
  get    "/trips",          to: "trips#index",  as: "trips"
  get    "/trips/new",      to: "trips#new",    as: "new_trip"
  post   "/trips",          to: "trips#create"
  get    "/trips/:id",      to: "trips#show",   as: "trip"
  get    "/trips/:id/edit", to: "trips#edit",   as: "edit_trip"
  patch  "/trips/:id",      to: "trips#update"
  delete "/trips/:id",      to: "trips#destroy"

  # Expenses (nested under trips)
  get    "/trips/:trip_id/expenses/new", to: "expenses#new",     as: "new_trip_expense"
  post   "/trips/:trip_id/expenses",     to: "expenses#create",  as: "trip_expenses"
  delete "/trips/:trip_id/expenses/:id", to: "expenses#destroy", as: "trip_expense"

  # Settlements
  get "/trips/:trip_id/settlements", to: "settlements#show", as: "trip_settlements"
end
