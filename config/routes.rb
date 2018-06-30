Rails.application.routes.draw do
  

  get 'lines/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'toppage#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users, only: [:show, :new, :create, :edit, :update]
  resources :posts, only: [:new, :create, :destroy]
  resources :lines, only: [:show]
end
