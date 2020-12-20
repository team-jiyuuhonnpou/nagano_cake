class Customers::OrdersController < ApplicationController

  #before_action :authenticate_customer!

  def new
    @order = Order.new
    @deliveries = current_customer.deliveries
  end

  def confirm
    @cart_items = current_customer.cart_items
  end

  def create
    @order = Order.new(order_params)
    @deliveries = current_customer.deliveries
    @order.fee=800
    @order.customer_id = current_customer.id
    if params["delivery_address"] == "1"
      @order.name = current_customer.last_name + current_customer.first_name
      @order.postcode = current_customer.postcode
      @order.address = current_customer.street_address
    elsif params["delivery_address"] == "2"
      @order.name = Delivery.find(params[:order][:select_address]).name
      @order.postcode = Delivery.find(params[:order][:select_address]).postcode
      @order.address = Delivery.find(params[:order][:select_address]).address
    elsif params["delivery_address"] == "3"
      @order.name = delivery.name
      @order.postcode = delivery.postcode
      @order.address =  delivery.address
    end

    @order.save!
    redirect_to  root_path
  end

  def thanks
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  private
  def order_params
     params.require(:order).permit(:postcode, :address, :name, :payment_method, :fee, :customer_id)
  end
end
