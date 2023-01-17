class ReviewsController < ApplicationController
before_action :set_movie
before_action :require_signin

def index
    @review = @movie.reviews
end

 def new
      @review = @movie.reviews.new
 end

 def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user
    if @review.save
        redirect_to movie_reviews_path(@movie),
        notice: "Thanks for your review!"
    else
        render :new, status: :unprocessable_entity
    end
 end

 def show
    @review = @movie.reviews.find(params[:id])
 end

 def edit 
    @review = @movie.reviews.find(params[:id])
 end

 def update
    @review = @movie.reviews.find(params[:id])
    if @review.update(review_params)
        flash[:notice] = "Review successfully updated!"
        redirect_to   movie_reviews_path(@movie,@review)
    else
        render :new, status: :unprocessable_entity
    end
 end

 def destroy
      @review = @movie.reviews.find(params[:id])
      @review.destroy
      flash[:notice]  = "All Review Deleted Successfully...!!"
      redirect_to movies_url, status: :see_other
 end

 private

 def review_params
    params.require(:review).permit(:stars,:comment)
 end

 def set_movie
    @movie = Movie.find_by!(slug: params[:movie_id])
 end
end
