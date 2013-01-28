class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter { |c| Authorization.current_user = c.current_user }

  def index
  	if user_signed_in?
  		if current_user.role.name == 'admin'
  			redirect_to companies_path
  		else
	  		redirect_to current_user.company
	  	end
  	else
  		redirect_to '/users/sign_in'
  	end
  end
end
