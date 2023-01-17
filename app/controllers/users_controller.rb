class UsersController < ApplicationController
    before_action :require_signin, except: [:new, :create]
    
    before_action :require_correct_user, only: [:edit, :update, :destroy]
    
    before_action :require_admin, only: [:destroy]
    

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @reviews = @user.reviews    
        @favorite_movies = @user.favorite_movies
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id]=@user.id
            redirect_to @user, notice: "Thanks for signing up"
        else
            render :new,status: :unprocessable_entity
        end
    end

    def edit
        # @user = User.find(params[:id])
    end

    def update
        # @user = User.find(params[:id])
        # binding.pry
        if @user.update(user_params)
            flash[:notice] = "User Successfully updated!"
            redirect_to @user
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        # @user = User.find(params[:id])
        @user.destroy
        session[:user_id]=nil
        redirect_to users_url, notice: "User Successfully Deleted!",status: :see_other
    end

    private

    def require_correct_user
        @user = User.find(params[:id])
        unless current_user?(@user)
            redirect_to root_url,status: :see_other
        end
    end
    
    def user_params
        params.require(:user).permit(:name,:email,:password,:password_confirmation,:username,:admin)
    end
end

