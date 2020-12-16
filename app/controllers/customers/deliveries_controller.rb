class Customers::DeliveriesController < ApplicationController
  
  before_action :authenticate_customer!
  
  def index
    @delivary = Delivery.new
    @deliveries = current_cunstomer.delivaries
  end

  def create
    @delivery = Derivery.new(derivery_params)
    if delivery.save
      redirect_to customers_deliveries_path
    else
      @deliveries = current_cunstomer.delivaries
      render :index
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivary.destroy
     redirect_to customers_deliveries_path
  end

  def edit
    @delivary = Delivery.find(params[:id])
  end

  def update
    @delivary = Delivery.find(params[:id])
    if @delivary.update(delivary_params)
      redirect_to customers_deliveries_path
    else
      #@delivary = Delivery.find(params[:id])
      render :edit
    end
  end
  
  private
  def delivery_params
    params.require(:delivary).permit(:postcode, :address, :name)
  end
  
end
