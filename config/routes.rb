Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  get 'toppages/index'
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:create]
  
  resources :units, only: [:index, :show, :edit, :update, :destroy]
  get 'units/:id/results', to: 'units#results', as: 'results'
  post 'units/:id/edit', to: 'units#edit', as: 'edit'
  post 'units/:id/destroy', to: 'units#destroy', as: 'destroy'
  
end
