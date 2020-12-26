class Admins::OrderItemsController < ApplicationController

  before_action :authenticate_admin!

  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    @order_item.update(order_item_params)
    count = @order.order_items.select(:production_status).distinct.count
      if @order_item.production_status == "製作中"
        @order.update(status: 2)
      elsif count == 1 && @order_item.production_status == "製作完了"
        @order.update(status: 3)
      end
      redirect_to  admins_order_path(@order)
  end

  private
  def order_item_params
    params.require(:order_item).permit(:production_status)
  end

end