class BooksController < ApplicationController
	def index
		@title = "All Books"
		@books = Book.all
	end
	
	def show
		@book = Book.find( params[:id] )
	end
end