'use strict';
angular.module('questionApp').constant('ConfiguratorService', function() {
  return {
    question_url: "http://localhost:port/questions.json",
    new_question_url: "http://localhost:port/questions/new.json",
    get_question_url: "http://localhost:port/questions/:id.json"
  };
});
