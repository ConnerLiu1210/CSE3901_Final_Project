Rails.application.routes.draw do
  # Static Pages
  root "static_pages#home"
  get 'home', to: 'static_pages#home', as:'home'
  get 'about', to: 'static_pages#about', as: 'about'

  #------------------------------------------------------
  # Example of possible trips routes
  # get    '/trips',          to: 'trips#index',   as: 'trips'
  # get    '/trips/new',      to: 'trips#new',     as: 'new_trip'
  # post   '/trips',          to: 'trips#create'
  # get    '/trips/:id',      to: 'trips#show',    as: 'trip'
  # get    '/trips/:id/edit', to: 'trips#edit',    as: 'edit_trip'
  # patch  '/trips/:id',      to: 'trips#update'
  # delete '/trips/:id',      to: 'trips#destroy'
end
