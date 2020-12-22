class HomesController < ApplicationController
  def top
    @items = Item.limit(4)
    @genres = Genre.where(is_active: 1)
  end
  
  def about
  end
end
