class BooksController < ApplicationController
	  before_action :authenticate_user!
	  before_action :correct_user, only: [:edit, :destroy]
	
	def index
	    @book = Book.new
	    @books = Book.all
	    @user = User.find(current_user.id)
	end


	def show
	    @book = Book.find(params[:id])
	    @new_book = Book.new
	    @user = @book.user 
	end


	def edit
	    @book = Book.find(params[:id])
	end

	def new
	end


	def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
    	@books = Book.all
    	@user = current_user
        if @book.save
		  # 作成に成功した場合、 /books/{book_id} にリダイレクト
		   redirect_to book_path(@book.id)
           flash[:notice] = "successfully"
		else
           render :index
           # infrc.html.erb
		  # 作成に失敗した場合、 /books/edit に戻してバリデーションエラーを表示する
		  # view 側で、 @book.errors を使ってエラーを表示する。
		end
	end


	def update
	    @book = Book.find(params[:id])
	    if
	      @book.update(book_params)
      	  redirect_to book_path(@book.id)
      	  flash[:notice] = "successfully"
    	else
    	  render :edit
    	end
	end


	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end
	

    private

    def correct_user
    	if current_user != Book.find(params[:id]).user
    		redirect_to books_path
    	end
    end

    def book_params
        params.require(:book).permit(:title,:body)
    end


end
