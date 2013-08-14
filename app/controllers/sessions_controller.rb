class SessionsController < Devise::SessionsController

  skip_before_filter :verify_authenticity_token
  before_filter :allow_cors_requests
  after_filter  :set_csrf_cookie_for_ng

  def new
    # self.resource = build_resource(nil, :unsafe => true)
    # clean_up_passwords(resource)
    # respond_with(resource, serialize_options(resource))
    render :json => { message: "login required" }, status: 401
  end

  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    sign_in_and_redirect(resource_name, resource)
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    return render :json => {:success => true, user: current_user.to_dto }
  end

  def failure
    return render :json => {:success => false, :errors => ["Login failed."]}
  end

  #cors
  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def allow_cors_requests
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE}.join(",")
    headers["Access-Control-Allow-Headers"] =
      %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")

    head(:ok) if request.request_method == "OPTIONS"
    # or, render text: ''
    # if that's more your style
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.json {
        render json: { user: {}, message: "logged out", status: 200 }
      }
    end
  end


  def options
    head(:ok)
  end

  protected

  def verified_request?
    super || form_authenticity_token == request.headers['X_XSRF_TOKEN']
  end

end
