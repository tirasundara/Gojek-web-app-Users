Rails.application.routes.draw do
  root 'static_pages#home'

  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/users/:id/topup', to: 'users#topup_gopay', as: 'topup_gopay'
  patch  '/users/:id/topup', to: 'users#update_gopay', as: 'update_gopay'

  # Order History
  get '/users/:id/orders/history', to: 'users#orders_history', as: 'order_history'

  # New Order
  get '/users/:id/orders/new', to: 'users#new_order', as: 'new_order'
  post '/users/:id/orders/new', to: 'users#initialize_order', as: 'initialize_order'
  post '/users/:id/orders/confirm_order', to: 'users#confirm_order', as: 'confirm_order'
  get '/users/:id/orders/on-process', to: 'users#current_order', as: 'current_order'

  resources :users
end
