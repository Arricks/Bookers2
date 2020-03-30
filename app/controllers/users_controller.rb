class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

	def index
      @book = Book.new
      @user = current_user
      @users = User.all
	end

	def new
	end


	def show
	  @user = User.find(params[:id])
	  @book = Book.new
	  @books = @user.books
	end


	def edit
	  if params[:id] == current_user.id
	    @user = User.find(params[:id])
	    render action: :edit
	  else
	    @user = current_user
	    render action: :show
	  end
	end
	
	def update
	  @user = User.find(params[:id])
	  if
	    @user.update(user_params)
	    flash[:notice] = "successfully."
	    redirect_to user_path(@user.id)
	  else
	    render :edit
	  end
	end


	private
	  def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	  end

	  def correct_user
        @user = User.find(params[:id])
        redirect_to(user_url(current_user)) unless @user == current_user
	  end



end
