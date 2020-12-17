class Customers::CartItemsController < ApplicationController
  
  #before_action :authenticate_customer!
  
  def index
    @cart_items = current_cunstomer.cart_items
  end
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.save
      redirect_to customers_cart_items_path
  end
  
  def update
    @cart_item =  CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
     redirect_to customers_cart_items_path
  end


  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
     redirect_to customers_cart_items_path
  end

  def destroy_all
    @cart_items = current_cunstomer.cart_items
    @cart_items.destroy
     redirect_to customers_cart_items_path
  end
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end
  
end
