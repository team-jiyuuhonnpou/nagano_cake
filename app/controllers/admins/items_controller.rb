class Admins::ItemsController < ApplicationController
  
  #before_action :authenticate_admin!
  
  def index
    @items = Item.all
    @items = Item.page(params[:page]).reverse_order.per(10)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "商品を登録しました"
      redirect_to admins_item_path(@item)
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admins_item_path(@item)
    else
      render :edit
    end
  end
  
  private
  def item_params
    params.require(:item).permit(:genre_id, :item_name, :explanation, :image, :non_taxed_price, :is_active)
  end
end
