Rails.application.routes.draw do
  root "posts#index"
  resources :posts
  resources :draft, only: [:create, :destroy, :index]
end
