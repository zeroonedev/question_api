class ApplicationController < ActionController::Base
  
  before_filter { |c| Authorization.current_user = c.current_user }
  
  protect_from_forgery


protected

  def permission_denied
    flash[:error] = "Sorry, you are not allowed to access that page."
    redirect_to root_url
  end

end
