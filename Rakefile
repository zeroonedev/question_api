#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

QuestionServer::Application.load_tasks

task :start_dev_server do
  run("rails s -d")
end

task :start_test_server do
  run("rails s -d -e test")
end

task :stop_server do
  run("kill -9 $(cat tmp/pids/server.pid)")
end

task :start_search_server do 
  run("elasticsearch -f -D es.config=/usr/local/Cellar/elasticsearch/0.90.1/config/elasticsearch.yml")
end

task :depsfe do
  run("cd question_app; npm install && node_modules/.bin/bower bower install")
end

task :buildfe do
  run("cd question_app; grunt build")
end

task :copyfe do
  ("cp -R question_app/dist/* public/ && cp question_app/dist/index.html app/views/layouts/client.html")
end

