class MoviesController < ApplicationController

  before_action :require_signin, except: [:show, :index]
  before_action :require_admin, except: [:show, :index]
  before_action :find_by_slug, only: [:show, :update, :edit, :destroy]

  def index
    # the 'send' method dynamically creates a method named after its param.
    # so here we are actually calling the result of the call to the movies_scope method
    # this will return one of the whitelisted params or the default.
    # resulting in a call to, say, Movie.hits.  This saves us from a long CASE statement.
    @movies = Movie.send(movies_scope)
    @genres = Genre.all
  end

  def show
    # need to have an @review vairable to show the review form partial
    # but if use the standard @review = @movie.reviews.new the instantiated
    # review will be counted so when we check the size of the review array to
    # display on the button, it would always be +1 the actual value.
    @review = Review.new
    @review.movie = @movie
    @fans = @movie.fans
    @genres = @movie.genres

    if current_user
      @current_favorite = current_user.favorites.find_by(movie_id: @movie.id)
    end
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
  end

  def update
    if @movie.update(secure_params)
      redirect_to @movie, notice: "Movie successfully updated!"
    else
      render :edit
    end

  end

  def destroy
    if @movie.delete
      redirect_to root_path, alert: "Movie '#{@movie.title}' deleted!"
    else
      render :show
    end
  end

  private

  # constrain the list of scope params that can be passed through.
  def movies_scope
    if params[:scope].in? %w(hits flops upcoming recent)
      params[:scope]
    else
      :released
    end
  end

  def find_by_slug
    @movie = Movie.find_by!(slug: params[:id])
  end

  def secure_params
    params.require(:movie).permit(:title,
                                  :description,
                                  :rating,
                                  :released_on,
                                  :total_gross,
                                  :cast,
                                  :director,
                                  :duration,
                                  # :image_file_name
                                  # replace above file field with the below paperclip
                                  # pseudo field
                                  :image,
                                  :slug,
                                  genre_ids: [])
  end

end
