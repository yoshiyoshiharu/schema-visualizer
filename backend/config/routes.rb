Rails.application.routes.draw do
  namespace :api do
    namespace :products do
      resources :tables, only: %i(index)
      resources :columns, only: %i(index)
    end
    resources :tables, only: %i() do
      resources :columns, only: %i(index), controller: 'tables/columns'
    end
    resources :columns, only: %i() do
      resource :comment, only: %i(update), controller: 'columns/comments'
    end
  end
end
