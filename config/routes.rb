Rails.application.routes.draw do
  root "posts#index"
  resources :posts do
    resources :comments
  end
  resources :tags, only: [:create, :destroy, :index]
  resources :drafts, only: [:create, :destroy, :index, :show]
end
