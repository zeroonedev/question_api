class CorsController < ActionController::Base
  def options
    head(:ok)
  end
end
