Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect('/customers')

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'logout', to: 'sessions#destroy'

  resources :orders, except: [:new, :create] do
    resource :start, controller: 'orders/start', only: [:update]
    resource :ship, controller: 'orders/ship', only: [:update]
    resource :complete, controller: 'orders/complete', only: [:update]
    resource :reset_status, controller: 'orders/reset_status', only: [:update]
  end
  resources :customers do
    resources :orders, only: [:new, :create]
    resource :address, except: [:show], controller: 'customers/address'
  end
end
