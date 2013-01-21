class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter { |c| Authorization.current_user = c.current_user }

  def index
  	if user_signed_in?
  		redirect_to '/companies'
  	else
  		redirect_to '/users/sign_in'
  	end
  end
end
