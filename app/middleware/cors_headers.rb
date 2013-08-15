require 'pp'

class CorsHeaders
  def initialize app
    @app = app
  end
  def call env

    puts "IN CORS MIDDLEWARE >>>"

    extra_headers = {
      "Access-Control-Allow-Origin"      => "http://localhost:8000",
      "Access-Control-Allow-Methods"     => "GET,POST,PUT,DELETE",
      "Access-Control-Allow-Headers"     => "Origin,Accept,Content-Type,X-Requested-With,X-CSRF-Token,X-XSRF-TOKEN",
      "Access-Control-Allow-Credentials" => "true"
    }

    status, headers, body = @app.call(env)
    response = Rack::Response.new body, status, headers.merge(extra_headers)

    result = response.finish

    puts "<<< IN CORS MIDDLEWARE"

    result
  end
end
