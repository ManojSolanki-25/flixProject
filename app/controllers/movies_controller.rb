class MoviesController < ApplicationController

    before_action :require_signin, except: [:index,:show]
    before_action :require_admin, except: [:index,:show]
    before_action :set_movie, only: [:show,:edit,:update,:destroy]

    def index
        # filter = params[:filter]
        # case filter
        # when "upcoming"
        #     @movie = Movie.upcoming
        # when "recent"
        #     @movie = Movie.recent
        # when "hits"
        #     @movie = Movie.hits
        # when "flops"
        #     @movie = Movie.flops
        # else
        #    @movie = Movie.released
        # end

        @movie = Movie.send(movies_filter)
    end

    def movies_filter
        if params[:filter].in? %w(upcoming recent hits flops)
            params[:filter]
        else
            :released
        end
    end
    
    def edit
    end

    def show
        @fans = @movie.fans
        @genres = @movie.genres.order(:name)

        if current_user
            @favorite = current_user.favorites.find_by(movie_id: @movie.id)
        end
    end
    
    def update
        if @movie.update(movie_params)
            flash[:notice] = "Movie successfully updated!"
            redirect_to @movie
        else
            render :new, status: :unprocessable_entity
        end
    end

    def new
        @movie = Movie.new
        
    end

    def create
        @movie = Movie.new(movie_params)
         if @movie.save
            flash[:notice] = "Movie successfully created!"     
            redirect_to @movie
         else
            render :new, status: :unprocessable_entity
         end
    end

    def destroy
        @movie.destroy
        flash[:notice] = "Movie successfully deleted!"     
        redirect_to movies_url, status: :see_other
    end

    private
    
    def set_movie
        @movie = Movie.find_by!(slug: params[:id])
    end

    def movie_params
        params.require(:movie).permit(:name,:rating,:total_gross,:description,:released_on,:director,:duration,:image_file_name,genre_ids: [])
    end

end
