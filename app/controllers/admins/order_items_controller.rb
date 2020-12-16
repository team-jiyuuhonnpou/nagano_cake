class Admins::OrderItemsController < ApplicationController
  
  before_action :authenticate_admin!
  
  def update
    @order_item = OrderItem.find(params[:id])
    @order = Order.find(params[:order_id])
    @order_items.update(order_item_params)
     if @order_item.production_status == 2
        @order.update(status: 2)
     elsif @order_item.production_status == 3
        @order.update(status: 3)
     end
      redirect_to  admins_order_path(@order)
      #render相談
  end
  
  private
  def order_item_params
    params.require(:order_item).permit(:production_status)
  end
  
end