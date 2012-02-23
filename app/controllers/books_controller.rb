class BooksController < ApplicationController
	def index
		@title = "All Books"
#		if Book.count > 0 
		@books = Book.all
#		else
#			redirect_to( "/" )
#			flash[:notice] = "The Book database is empty!"
#		end
	end
	
	def show
		@book = Book.find( params[:id] )
		@title = "Book Info: "+ @book.title + " by " + @book.author
	end
	
	#TODO def create
	#TODO def update
	#TODO def delete
end