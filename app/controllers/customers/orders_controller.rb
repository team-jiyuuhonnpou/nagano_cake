class Customers::OrdersController < ApplicationController
  
  #before_action :authenticate_customer!
  
  def new
    @order = Order.new
    @deliveries = current_cunstomer.deliveries
  end

  def confirm
    @cart_items = current_cunstomer.cart_items
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to ustomers_orders_thanks_path
  end

  def thanks
  end

  def index
    @orders = current_cunstomer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end
  
  private
  def order_params
    params.require(:order).permit(:postcode, :address, :name, :payment_method)
  end
end
