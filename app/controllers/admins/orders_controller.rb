class Admins::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @orders = Order.all
    @orders = Order.page(params[:page]).reverse_order.per(8)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @total_price = 0
    @order_items.each do |order_item|
      @total_price += (order_item.item.non_taxed_price * 1.1).floor * order_item.amount
    end
  end

  def update
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    if @order.update(order_params)
      if @order.status == "入金確認"
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
