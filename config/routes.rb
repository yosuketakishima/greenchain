Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:create]
  
  get 'results', to: 'results#index'
  
  resources :units, only: [:index, :show, :edit, :update, :destroy]
  get 'units/:id/results', to: 'units#results', as: 'result'
  post 'units/:id/edit', to: 'units#edit', as: 'edit'
  post 'units/:id/destroy', to: 'units#destroy', as: 'destroy'
  
  get 'tests', to: 'toppages#tests'
  
end
