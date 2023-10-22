Rails.application.routes.draw do
  namespace :api do
    resources :products, only: %i(index)
    resources :tables, only: %i() do
      resources :columns, only: %i(index), controller: 'tables/columns'
    end
    resources :columns, only: %i(index)
  end
end
