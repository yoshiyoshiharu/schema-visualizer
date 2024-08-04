Rails.application.routes.draw do
  root to: 'home#index'
  resource :home, only: %w(index)
  resource :healthcheck, only: :show

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  resource :sessions, only: %w(new create)

  resources :users
  resources :products, only: %w(index new create edit update destroy)
  resources :tables, only: %w(index show)
  resources :columns, only: %w(index)

  resources :columns, only: %w() do
    resource :memo, only: %w(show edit update), controller: 'column_memos'
  end

  get '*not_found' => 'application#raise_routing_error'
  post '*not_found' => 'application#raise_routing_error'
end
