class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
  def movie_params2
    params.require(:movie).permit(:oldtitle, :title, :rating, :description, :release_date)
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
    #@movie = Movie.find params[:id]
    #if((movie_params[:title]).blank? || movie_params[:release_date].blank? || movie_params[:rating].blank?)
    #  flash[:notice] = "error fields empty"
    #  redirect_to movies_path
    #  return
    #end
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
  def deletemovie
    #if !(params[:title].nil?)
    #  @movie = Movie.find(params[:title])
    #  flash[:notice] = "Movie '#{@movie.title}' deleted."
    #  redirect_to movies_path
    #  @movie.destroy
    #  return
    #end
  end
  def updatemov
    #@movie = Movie.find_by movie_params2[:tmp]
    
  #  if((movie_params[:title]).blank? || movie_params[:release_date].blank? || movie_params[:rating].blank?)
  #    flash[:notice] = "error fields empty"
   #   redirect_to movies_path
  #    return
  #  end
  #  @movie.update_attributes!(movie_params)
  #  flash[:notice] = "#{@movie.title} was successfully updated."
  #  redirect_to movie_path(@movie)
  end
  def update_mov
    @movie = Movie.find_by movie_params2[:tmp]
    
    if((movie_params2[:title]).blank? || movie_params2[:release_date].blank? || movie_params2[:rating].blank?)
      flash[:notice] = "error fields empty"
      redirect_to movies_path
      return
    end
    @movie.update_attributes!(movie_params2)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end
  def delete_mov

    @movies = Movie. all
    args = params.require(:movie).permit(:title, :rating)
    if !((args[:rating]).blank?)
      @movies = @movies.where(:rating => args[:rating])
      @movies.all.each do |i|
        i.destroy
      redirect_to movies_path
    end
    return
    elsif !((args[:title]).blank?)
      @movie = Movie.find_by_title(args[:title])
      flash[:notice] = "Movie '#{@movie.title}' deleted."
      @movie.destroy
      redirect_to movies_path
      return
    
    end
    flash[:notice] = "both left blank"
    redirect_to movies_path

      
  end

end
