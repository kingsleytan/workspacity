Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'landing#index'
  get :about, to: 'static_pages#about'
  resources :users, only: [:new, :edit, :create, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :services
  resources :packages do
    resources :reviews
  end
  resources :orders
  resources :ordered_items
  resources :password_resets, only: [:new, :create, :edit, :update]
end
