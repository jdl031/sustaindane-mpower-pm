class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
  	if user_signed_in?
  		redirect_to '/companies'
  	else
  		redirect_to '/users/sign_in'
  	end
  end
end
