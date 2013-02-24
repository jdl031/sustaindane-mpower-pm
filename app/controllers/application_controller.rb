class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  
  protect_from_forgery
  before_filter { |c| Authorization.current_user = c.current_user }

  def index
  	if user_signed_in?
  		if current_user.role.name == 'admin'
  			redirect_to companies_path, :notice => flash[:notice]
  		else
	  		redirect_to current_user.company, :notice => flash[:notice]
	  	end
  	end
  end
  def permission_denied
    flash[:notice] = "Sorry, you not allowed to access that page."
    redirect_to root_url
  end
end
