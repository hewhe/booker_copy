class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]
	def index
		@books = Book.all
		@booknew = Book.new #newのviewはそのうち消す
	end

	def show
		@book = Book.find(params[:id])
		@booknew = Book.new
	end

	def new
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			flash[:notice] = "successfully created"
		redirect_to book_path(@book.id)
		else
			#flash[:notice] = "error"
			@books = Book.all
			@booknew = @book #！
			render :index
		end
	end

	def destroy
	    @book = Book.find(params[:id])
	    @book.destroy
	    redirect_to books_path
	end

	def edit
  		@book = Book.find(params[:id])
	end

	def update
	 	@book = Book.find(params[:id])
	 	@book.user_id = current_user.id
		if @book.update(book_params)
		flash[:notice] = "successfully Updated"
		redirect_to book_path(@book.id)
		else
			render :edit
		end
	end

	private
		def book_params
			params.require(:book).permit(:title, :body)
		end

		def correct_user
			book = Book.find(params[:id])
			if current_user.id != book.user.id
				redirect_to books_path
			end
		end
end
