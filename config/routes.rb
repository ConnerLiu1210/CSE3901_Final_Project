Rails.application.routes.draw do
  #get 'home', to: 'static_pages#home'
  root "static_pages#home" 
  get 'help', to: 'static_pages#help'
  get 'about', to: 'static_pages#about'
  get 'link', to: 'static_pages#link'
  #------------------------------------------------------
  get 'users', to: 'users#index'
  get 'users/new', to: 'users#new', as: 'new_user'
  get 'users/:id', to: 'users#show', as: 'user'
  post 'users', to: 'users#create'  
  delete 'users/:id',to: 'users#destroy'
  get 'users/:id/edit', to: 'users#edit', as: 'edit_user'
  patch 'users/:id', to: 'users#update'
  #resources :users
end
