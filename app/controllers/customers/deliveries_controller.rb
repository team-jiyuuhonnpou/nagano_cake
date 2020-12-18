class Customers::DeliveriesController < ApplicationController
  
  #before_action :authenticate_customer!
  
  def index
    @delivery = Delivery.new
    @deliveries = current_customer.deliveries
  end

  def create
    @delivery = Delivery.new(delivery_params)
    if @delivery.save
      redirect_to customers_deliveries_path
    else
      @deliveries = current_customer.deliveries
      render :index
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
     redirect_to customers_deliveries_path
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivary_params)
      redirect_to customers_deliveries_path
    else
      #@delivary = Delivery.find(params[:id])
      render :edit
    end
  end
  
  private
  def delivery_params
    params.require(:delivery).permit(:postcode, :address, :name)
  end
  
end
