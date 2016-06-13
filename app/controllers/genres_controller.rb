class GenresController < ApplicationController

  before_action :require_signin, except: [:show, :index]
  before_action :require_admin, except: [:show, :index]

  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @movies = @genre.movies
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      redirect_to genres_path, notice: "Genre Added"
    else
      render :new
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])

    if @genre.update(genre_params)
      redirect_to @genre, notice: "Genre renamed successfully"
    else
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])

    if @genre.delete
      redirect_to genres_path, alert: "Gnere '#{@genre.name}' deleted!"
    else
      render :show
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
