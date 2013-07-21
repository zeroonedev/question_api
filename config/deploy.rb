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
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache
set :rails_env, 'production'
set :use_sudo, false
set :normalize_asset_timestamps, false
set :git_enable_submodules, 1


after "deploy:update_code", "deploy:migrate"

namespace :deploy do

  after :update_code do
    `bundle exec rake install_front_end_deps` 
  end

  task :start do
    `bundle exec puma -e production -d -b unix:///tmp/question_api.sock  --pidfile /tmp/puma.pid`
  end

  task :stop do
    `kill -s SIGTERM $(cat /tmp/puma.pid)`
  end

  task :restart do
    `kill -s SIGUSR2 $(cat /tmp/puma.pid)`
  end

  task :uname do
    run "uname -a"
  end

  task :ruby_version do
    run "ruby --v"
  end
end
