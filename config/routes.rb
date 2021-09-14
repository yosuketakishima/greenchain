Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :units, only: [:index, :show, :edit, :update, :destroy]
  get 'units/:id/results', to: 'unists#results'
end
