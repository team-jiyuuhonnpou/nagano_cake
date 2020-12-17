class Admins::OrdersController < ApplicationController
  
  #before_action :authenticate_admin!
  
  def index
    @orders = Order.all
    @orders = Order.page(params[:page]).reverse_order.per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def update
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    if @order.update(order_params)
      if @order.status == 1
         @order_items.update(production_status: 1)
      end
      redirect_to  admins_order_path(@order)
    else
      render :show
    end
  end
  
  private
  def order_params
    params.require(:order).permit(:status)
  end
end
