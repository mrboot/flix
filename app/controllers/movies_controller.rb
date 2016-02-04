class MoviesController < ApplicationController
  def index
    @movies = Movie.released
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(secure_params)

    @movie.save

    redirect_to @movie
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    @movie.update(secure_params)

    redirect_to @movie
  end

  def destroy
    @movie = Movie.find(params[:id])

    @movie.delete

    redirect_to root_path
  end

  private

  def secure_params
    params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross)
  end

end
