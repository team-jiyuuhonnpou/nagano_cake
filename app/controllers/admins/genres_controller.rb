class Admins::GenresController < ApplicationController

  #before_action :authenticate_admin!

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

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    #フラグについて
  end
  
  
  private
  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end
  
end
