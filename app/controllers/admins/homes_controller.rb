class Admins::HomesController < ApplicationController
  
  #before_action :authenticate_admin!
  
  def top
    @orders = Order.all
    #@order_count = Order.where("created_at between '#{Date.today} 0:00:00' and '#{Date.today} 23:59:59'").count
  end
end
