Rails.application.routes.draw do
  get 'toppages/index'
  root to: 'toppages#index'
  
  resources :units, only: [:index, :show, :edit, :update, :destroy]
  get 'units/:id/results', to: 'units#results', as: 'results'
  post 'units/:id/edit', to: 'units#edit', as: 'edit'
  post 'units/:id/destroy', to: 'units#destroy', as: 'destroy'
  
end
