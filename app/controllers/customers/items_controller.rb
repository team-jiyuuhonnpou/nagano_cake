class Customers::ItemsController < ApplicationController

  def index
    @items = Item.all
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

  def genre_search
    @items = Item.all
    @items = Item.page(params[:page]).reverse_order.per(8)
    @genre = Genre.find(params[:id])
    @genres = Genre.all
    @genre_item = @genre.items.order(creates_at: :desc).all.page(params[:page]).per(5)
  end


end
