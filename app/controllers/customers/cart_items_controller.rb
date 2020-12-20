class Customers::CartItemsController < ApplicationController

  #before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += (cart_item.item.non_taxed_price * 1.1).floor * cart_item.amount
    end
  end
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    # @cart_item.item_id =
    @cart_item.customer_id = current_customer.id
    @cart_item.save!
      redirect_to customers_cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.customer_id = current_customer.id
    @cart_item.update(cart_item_params)
     redirect_to customers_cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
     redirect_to customers_cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
     redirect_to customers_cart_items_path
  end
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end

end
