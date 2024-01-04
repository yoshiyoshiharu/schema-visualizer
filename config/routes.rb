Rails.application.routes.draw do
  root to: 'home#index'
  resource :home, only: %w(index)

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  resource :sessions, only: %w(new create)

  resources :users
  resources :products, only: %w(index)
  resources :tables, only: %w(show)

  resources :columns, only: %w() do
    resource :memo, only: %w(show edit update), controller: 'column_memos'
  end
end
