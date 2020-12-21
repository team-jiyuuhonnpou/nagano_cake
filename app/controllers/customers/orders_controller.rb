class Customers::OrdersController < ApplicationController

  #before_action :authenticate_customer!

  def new
    @order = Order.new
    @deliveries = current_customer.deliveries
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += (cart_item.item.non_taxed_price * 1.1).floor * cart_item.amount
    end
    if params["delivery_address"] == "1"
      @order.name = current_customer.last_name + current_customer.first_name
      @order.postcode = current_customer.postcode
      @order.address = current_customer.street_address
    elsif params["delivery_address"] == "2"
      @order.name = Delivery.find(params[:order][:select_address]).name
      @order.postcode = Delivery.find(params[:order][:select_address]).postcode
      @order.address = Delivery.find(params[:order][:select_address]).address
    elsif params["delivery_address"] == "3"
      @order.name = params[:order][:name]
      @order.postcode = params[:order][:postcode]
      @order.address =  params[:order][:address]
    end
  end

  def create
    @cart_items = current_customer.cart_items
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += (cart_item.item.non_taxed_price * 1.1).floor * cart_item.amount
    end
    @order = Order.new(order_params)
    @deliveries = current_customer.deliveries
    @order.fee = 800
    @order.payment = @total_price
    @order.customer_id = current_customer.id

    if @order.save
      @cart_items = current_customer.cart_items
      @order_item = OrderItem.new
      @cart_items.each do |cart_item|
      @order_item.item_id = cart_item.item_id
      @order_item.amount = cart_item.amount
      @order_item.price = cart_item.item.non_taxed_price
      @order_item.order_id = @order.id
      end
      @order_item.save
  
      @cart_items.destroy_all
      redirect_to  customers_orders_thanks_path
    end



  end

  def thanks
  end

  def index
    @orders = current_customer.orders.all
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
