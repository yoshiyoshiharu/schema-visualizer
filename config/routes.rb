Rails.application.routes.draw do
  resources :tables, only: %w(show)
end
