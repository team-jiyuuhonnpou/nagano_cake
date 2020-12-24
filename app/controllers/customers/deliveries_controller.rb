class Customers::DeliveriesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_delivery, only: [:edit, :update, :destroy]
  
  def index
    @delivery = Delivery.new
    @deliveries = current_customer.deliveries
  end
  
  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    if @delivery.save
      redirect_to customers_deliveries_path
    else
      @deliveries = current_customer.deliveries
      render :index
    end
  end

  def destroy
    @delivery.destroy
     redirect_to customers_deliveries_path
  end

  def edit
  end

  def update
    if @delivery.update(delivery_params)
      redirect_to customers_deliveries_path
    else
      render :edit
    end
  end
  
  private
  def delivery_params
    params.require(:delivery).permit(:postcode, :address, :name, :customer_id)
  end
  
  def set_delivery
    @delivery = Delivery.find(params[:id])
  end
end
