class MoviesController < ApplicationController
  def index
    @movies = Movie.released
  end

  def show
    @movie = Movie.find(params[:id])
    # need to have an @review vairable to show the review form partial
    # but if use the standard @review = @movie.reviews.new the instantiated
    # review will be counted so when we check the size of the review array to
    # display on the button, it would always be +1 the actual value.
    @review = Review.new
    @review.movie = @movie
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
