class BooksController < ApplicationController
	def index
		@title = "All Books"
		@books = Book.all
	end
end