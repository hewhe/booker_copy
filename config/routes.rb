Rails.application.routes.draw do
  devise_for :users
  root "homes#index"
  resources :homes, only: [:index, :show]
  resources :users, only: [:show, :index, :edit, :update]
  resources :books, only: [:index, :show, :new, :create, :destroy, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
