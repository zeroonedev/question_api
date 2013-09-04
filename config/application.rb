require File.expand_path('../boot', __FILE__)

require 'rails/all'
require './app/middleware/cors_headers.rb'
require 'csv'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))

  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module QuestionServer
  class Application < Rails::Application

    config.encoding = "utf-8"

    config.autoload_paths += Dir["#{Rails.root}/lib/modules"]

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true

    config.assets.initialize_on_precompile = false

    config.assets.precompile += %w(rails_admin/rails_admin.js rails_admin/rails_admin.css)

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.middleware.insert_before ActionDispatch::ShowExceptions, CorsHeaders
  end
end
