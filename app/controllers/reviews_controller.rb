class ReviewsController < ApplicationController

  before_action :set_movie
  before_action :require_signin

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(secure_params)
    @review.user = current_user

    if @review.save
      redirect_to movie_reviews_path(@movie), notice: "Thanks for your review!"
    else
      render :new
    end
  end

  def edit
    @review = @movie.reviews.find(params[:id])
  end

  def destroy
    @review = @movie.reviews.find(params[:id])
    if @review.delete
      redirect_to movie_reviews_path(@movie), alert: "Review deleted!"
    else
      render :index
    end
  end

  private

  def set_movie
    @movie = Movie.find((params[:movie_id]))
  end

  def secure_params
    params.require(:review).permit( :location, :stars, :comment )
  end

end
