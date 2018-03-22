Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect('/customers')

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'logout', to: 'sessions#destroy'

  resources :orders, except: %i[new create] do
    resource :start, controller: 'orders/start', only: %i[update]
    resource :ship, controller: 'orders/ship', only: %i[update]
    resource :complete, controller: 'orders/complete', only: %i[update]
    resource :reset_status, controller: 'orders/reset_status', only: %i[update]
  end
  resources :customers do
    resources :orders, only: %i[new create]
    resource :address, except: %i[show], controller: 'customers/address'
  end
end
