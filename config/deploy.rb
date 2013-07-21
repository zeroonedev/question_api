set :stages, %w(development production staging)
set :default_stage, "development"
require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require "capistrano-rbenv"
require 'capistrano/grunt'

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

set :grunt_tasks, 'build'
set :grunt_options, '--gruntfile Gruntfile.js'

default_run_options[:pty] = true



  namespace :grunt_sub do
    desc 'Runs the Grunt tasks or the default task if none are specified in grunt_tasks.'
    task :default, :roles => :app, :except => { :no_release => true } do
      tasks = Array(grunt_tasks)
      tasks.each do |task|
        try_sudo "cd #{latest_release}/question_app && grunt #{grunt_options} #{task}"
      end
    end
  end

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

  # desc "Refresh shared node_modules symlink to current node_modules"
  # task :refresh_symlink do
  #   run "rm -rf #{current_path}/question_app/node_modules && ln -s #{shared_path}/node_modules #{current_path}/question_app/node_modules"
  # end
 
  # desc "Install node modules non-globally"
  # task :npm_install do
  #   run "cd #{current_path}/question_app && npm install"
  # end

  desc "Install bower modules non-globally"
  task :bower_install do
    run "cd #{current_path}/question_app && bower install"
  end

  task :install_grunt do
    run "cd #{current_path}/question_app; which grunt"
  end

  before "deploy:finalize_update", "npm:install", "deploy:bower_install"
  # after "deploy:npm_install", "deploy:install_grunt"
  after 'deploy:finalize_update', 'grunt_sub'
end
