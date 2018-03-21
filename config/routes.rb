Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'customers#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'logout', to: 'sessions#destroy'

  resources :orders, except: [:new, :create]
  resources :customers do
    resources :orders, only: [:new, :create]
    resource :address, except: [:show], controller: 'customers/address'
  end
end
