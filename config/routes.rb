Rails.application.routes.draw do
  root to: 'home#index'
  resource :home, only: %w(index)

  resources :tables, only: %w(index show)

  resources :columns, only: %w() do
    resource :memo, only: %w(show edit update), controller: 'column_memos'
  end
end
