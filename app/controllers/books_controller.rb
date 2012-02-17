class BooksController < ApplicationController
	def index
		@title = "All Books"
		@books = Book.all
	end
	
	def show
		@book = Book.find( params[:id] )
		@title = "Book Info: "+ @book.title + " by " + @book.author
	end
end