Rails.application.routes.draw do
  namespace :api do
    resources :products, only: %i(index)
    resources :tables, only: %i(index)
    resources :columns, only: %i(index)
  end
end
