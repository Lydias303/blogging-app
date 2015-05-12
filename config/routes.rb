Rails.application.routes.draw do
  root "posts#index"
  resources :posts
  resources :drafts, only: [:create, :destroy, :index, :show]
end
