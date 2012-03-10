class ApplicationController < ActionController::Base
  protect_from_forgery
  def after_sign_in_path_for(user)
    return user_path(user) || root_path
  end
end
