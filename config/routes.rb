Rails.application.routes.draw do
  root to: 'home#index'
  resource :home, only: %w(index)

  resources :tables, only: %w(index show)
end
