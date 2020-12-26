Rails.application.routes.draw do

  devise_for :admins
  devise_for :customers, :controllers => {
    :sessions => 'customers/sessions'
  }
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
    get '/orders/thanks' => 'orders#thanks'
    resources :orders, only: [:new, :create, :index, :show]
    post '/orders/confirm' => 'orders#confirm'

    resources :items, only: [:index, :show]
    get '/items/genre_search/:id' => 'items#genre_search'
    resource :customer, only: [:show, :edit, :update]
    get '/customers/unsubscribe' => 'customers#unsubscribe'
    patch '/customers/hide' => 'customers#hide'
    resources :deliveries, only: [:index, :create, :destroy, :edit, :update]
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :create, :destroy, :update]
  end

end
