Rails.application.routes.draw do
  get 'users/show'
  get 'comments/create'
  devise_for :users
  root to: "prototypes#index"
  resources :users, only: [:index,:destroy, :new, :create, :show]
  resources :prototypes do
    resources :comments, only:[:create]
  end
end
