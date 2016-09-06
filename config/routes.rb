Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'landing#index'
  get :about, to: 'static_pages#about'

  # resources :users, only: [:new, :edit, :create, :update]
  # resources :sessions, only: [:new, :create, :destroy]

  resources :services
  resources :packages do
    resources :reviews
  end
  resources :orders, only: [:new, :create, :show]
  resources :ordered_items
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :shippings

  get :cart, to: "carts#show"
  post :add_package, to: "carts#add_package"
  delete :remove_package, to: "carts#remove_package"
  delete :clear_cart, to: "carts#clear_cart"
  patch :update_package, to: "carts#update_package"

  scope '/webhooks', controller: :webhooks do
    post 'payment-callback', to: 'webhooks#payment_callback', as:
      :payment_callback
  end

  match 'auth/:provider/callback', to: 'oauth#create', via: [:get, :post]
  match 'auth/failure', to: 'oauth#failure', via: [:get, :post]
  match 'signout', to: 'oauth#destroy', as: 'signout', via: [:get, :post]

end
