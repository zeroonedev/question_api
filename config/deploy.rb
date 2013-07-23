set :stages, %w(development production staging)
set :default_stage, "development"
require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require "capistrano-rbenv"

set :rbenv_ruby_version, "2.0.0-p247"

set :application, "question_api"
set :user, "www-data"
set :group, "www-data"

set :scm, :git
set :repository, "git@github.com:zeroonedev/#{application}.git"
set :deploy_to, "/home/deploy/#{application}"
set :deploy_via, :remote_cache
set :rails_env, 'production'
set :use_sudo, false
set :normalize_asset_timestamps, false

default_run_options[:pty] = true

namespace :deploy do


  before :update_code do
    run ". ~/.profile"
  end

  task :start do
    run "#{sudo} bundle exec puma -e production -d -b unix:///var/run/question_api.sock --pidfile /var/run/puma.pid"
  end

  task :stop do
    sudo "#{sudo} kill -s SIGTERM $(cat /var/run/puma.pid)"
  end

  task :restart do
    sudo "#{sudo} kill -s SIGUSR2 $(cat /var/run/puma.pid)"
  end
  task :uname do
    run "uname -a"
  end

  task :ruby_version do
    run "ruby --v"
  end


  before "deploy:finalize_update", "deploy:migrate"

end
