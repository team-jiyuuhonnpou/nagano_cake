class HomesController < ApplicationController
  def top
    @items = Item.where(is_active: 1).limit(4)
    @genres = Genre.where(is_active: 1)
  end
  
  def about
  end
end
