Rails.application.routes.draw do
  namespace :admins do
    get 'homes/top'
  end

  namespace :admins do
    get 'genres/index'
  end

  namespace :admins do
    get 'genres/create'
  end

  namespace :admins do
    get 'genres/destroy'
  end

  namespace :admins do
    get 'genres/edit'
  end

  namespace :admins do
    get 'genres/update'
  end

  namespace :admins do
    get 'customers/index'
  end

  namespace :admins do
    get 'customers/show'
  end

  namespace :admins do
    get 'customers/edit'
  end

  namespace :admins do
    get 'customers/update'
  end

  namespace :admins do
    get 'customers/hide'
  end

  namespace :admins do
    get 'items/index'
  end

  namespace :admins do
    get 'items/show'
  end

  namespace :admins do
    get 'items/new'
  end

  namespace :admins do
    get 'items/edit'
  end

  namespace :admins do
    get 'items/create'
  end

  namespace :admins do
    get 'items/update'
  end

  namespace :admins do
    get 'order_items/update'
  end

  namespace :admins do
    get 'orders/index'
  end

  namespace :admins do
    get 'orders/show'
  end

  namespace :admins do
    get 'orders/update'
  end

  namespace :customers do
    get 'cart_items/index'
  end

  namespace :customers do
    get 'cart_items/create'
  end

  namespace :customers do
    get 'cart_items/destroy'
  end

  namespace :customers do
    get 'cart_items/destroy_all'
  end

  namespace :customers do
    get 'cart_items/update'
  end

  namespace :customers do
    get 'homes/top'
  end

  namespace :customers do
    get 'homes/about'
  end

  namespace :customers do
    get 'deliveries/index'
  end

  namespace :customers do
    get 'deliveries/create'
  end

  namespace :customers do
    get 'deliveries/destroy'
  end

  namespace :customers do
    get 'deliveries/edit'
  end

  namespace :customers do
    get 'deliveries/update'
  end

  namespace :customers do
    get 'customers/show'
  end

  namespace :customers do
    get 'customers/edit'
  end

  namespace :customers do
    get 'customers/update'
  end

  namespace :customers do
    get 'customers/unsubscribe'
  end

  namespace :customers do
    get 'customers/hide'
  end

  namespace :customers do
    get 'items/index'
  end

  namespace :customers do
    get 'items/show'
  end

  namespace :customers do
    get 'orders/new'
  end

  namespace :customers do
    get 'orders/confirm'
  end

  namespace :customers do
    get 'orders/create'
  end

  namespace :customers do
    get 'orders/thanks'
  end

  namespace :customers do
    get 'orders/index'
  end

  namespace :customers do
    get 'orders/show'
  end

  devise_for :admins
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #homes
  root to: 'homes#top'
  get '/about' => 'homes#about'

  #admins
  namespace :admins do
    #devise_for :admins
    resources :orders, only: [:index, :show, :update] do
      patch '/order_items/:id' => 'order_items#update'
    end
    resources :items, except: [:destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    patch '/custamers/:id/hide' => 'customers#hide'
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    get '/homes/top' => 'homes#top'
  end

  #custamer
  namespace :customers do
    #devise_for :customers
    resources :orders, only: [:new, :create, :index, :show]
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/thanks' => 'orders#thanks'
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update]
    get '/customers/unsubscribe' => 'custamers#unsubscribe'
    patch '/customers/hide' => 'customers#hide'
    resources :deliveries, only: [:index, :create, :destroy, :edit, :update]
    resources :cart_items, only: [:index, :create, :destroy, :update]
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
  end

end
