class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  def index 
    @movies = Movie.all
    @all_ratings = Movie.get_possible_ratings
    if params[:sort_by] == "title"
      @movies = @movies.sort_by &:title
    elsif params[:sort_by] == "release_date"
      @movies = @movies.sort_by &:release_date
    end
    if !(params[:ratings].nil?)
      @movies = @movies.find_all{ |m| params[:ratings].has_key?(m.rating) }
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    if((movie_params[:title]).blank? || movie_params[:release_date].blank? || movie_params[:rating].blank?)
      flash[:notice] = "error fields empty"
      redirect_to movies_path
      return
    end
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
