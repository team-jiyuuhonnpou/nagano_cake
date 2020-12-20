class Admins::GenresController < ApplicationController

  #before_action :authenticate_admin!, expect: [:show]

  def index
    @genre = Genre.new
    @genres = Genre.all
    @genres = Genre.page(params[:page]).reverse_order.per(8)
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admins_genres_path
    else
      @genres = Genre.all
      @genres = Genre.page(params[:page]).reverse_order.per(8)
      render :index
    end
  end

  def show
    @items = Item.all
    @items = Item.page(params[:page]).reverse_order.per(10)
    @genre = Genre.find(params[:id])
    @genres = @genre.items.order(creates_at: :desc).all.page(params[:page]).per(5)
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admins_genres_path
    else
      render :edit
    end
  end


  private
  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end

end
