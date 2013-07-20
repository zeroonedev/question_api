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

after :update_code do
  `bundle exec rake install_front_end_deps`
end

task :start do
  `bundle exec puma -e production -d -b unix:///var/run/question_api.sock  --pidfile /var/run/puma.pid`
end

task :stop do
  `kill -s SIGTERM $(cat /var/run/puma.pid)`
end

task :restart do
  `kill -s SIGUSR2 $(cat /var/run/puma.pid)`
end

task :uname do
  run "uname -a"
end

task :ruby_version do
  run "ruby --v"
end
