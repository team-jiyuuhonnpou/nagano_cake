class Customers::ItemsController < ApplicationController
  
  def index
    @items = Item.all
    @items = Item.page(params[:page]).reverse_order.per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end
  
  
end
