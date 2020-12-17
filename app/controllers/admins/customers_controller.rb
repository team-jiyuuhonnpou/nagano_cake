class Admins::CustomersController < ApplicationController
  
  #before_action :authenticate_admin!
  
  
  def index
    @customers = Customer.all
    @customers = Customer.page(params[:page]).reverse_order.per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admins_customer_path(@customer)
    else
      render :edit
    end
  end

  def update
  end

  def hide
  end
  
  private
  def customer_params
    params.require(:customer).permit(:last_name,:first_name,:kana_last_name,:kana_first_name,:postcode,:street_address,:phone_number,:email,:encrypted_password,:is_unsubscribed)
  end
end
