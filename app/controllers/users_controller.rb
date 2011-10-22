class UsersController < ApplicationController

	def index
    @title = "All Users"
    @users = User.all
  end

end
