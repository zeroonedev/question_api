'use strict';
angular.module('questionApp').filter('questionRestCleaner', function() {
  return function(question) {
    delete question.category;
    delete question.writer;
    return question;
  };
});
