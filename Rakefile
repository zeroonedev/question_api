#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

QuestionServer::Application.load_tasks

task :start_dev_server do
  `rails s -d`
end

task :start_test_server do
  `rails s -d -e test`
end

task :stop_server do
  `kill -9 $(cat tmp/pids/server.pid)`
end
