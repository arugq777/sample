class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [ :index ]

  def index
    @title = "All Users"
    @users = User.all
  end
  
  def show
    @user      = User.find(params[:id])
    @favorites = @user.favorites
    @title     = "User Profile: " + @user.name
    respond_to do |format|
      format.html
      format.xml {render xml: @user}
      format.json {render json: @user}
    end
  end

end