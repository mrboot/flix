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

    if @movie.save
      redirect_to @movie, notice: "Movie was successfully created!"
    else
      render :new
    end

  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(secure_params)
      redirect_to @movie, notice: "Movie successfully updated!"
    else
      render :edit
    end

  end

  def destroy
    @movie = Movie.find(params[:id])

    if @movie.delete
      redirect_to root_path, alert: "Movie '#{@movie.title}' deleted!"
    else
      render :show
    end
  end

  private

  def secure_params
    params.require(:movie).permit(:title,
                                  :description,
                                  :rating,
                                  :released_on,
                                  :total_gross,
                                  :cast,
                                  :director,
                                  :duration,
                                  :image_file_name)
  end

end
