class Customers::CustomersController < ApplicationController

  #before_action :authenticate_customer!

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customers_customer_path
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def hide
    @customer.update(is_unsubscribed: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :postcode, :street_address, :phone_number, :email, :encrypted_password)
  end
  
  
end
