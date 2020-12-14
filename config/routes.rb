Rails.application.routes.draw do
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
