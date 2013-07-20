class ApplicationController < ActionController::Base
  
  rescue_from CanCan::AccessDenied do |exception|
    render json: { message: "Not found" }, status: 403
  end

  protect_from_forgery



  def render_403(exception)
    pry
    logger.warn("Unauthorized access. Request: #{request.env}")
    @forbidden_path = request.url
    @error_message = exception.message
    respond_to do |format|
      format.html { render template: 'errors/error_403', layout: 'layouts/application', status: 403 }
      format.json { render json: { message: "Not found" }, status: 403 }
    end
  end

end
