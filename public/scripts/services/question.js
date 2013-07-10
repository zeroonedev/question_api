'use strict';
angular.module('questionApp').factory('Question', function($resource) {
  return $resource("/questions/:id.json", {
    id: '@id'
  }, {
    update: {
      method: 'PUT'
    }
  });
}).factory('QuestionsLoader', function(Question, $q) {
  return function(paginationParams) {
    var delay;
    delay = $q.defer();
    if (!paginationParams) {
      paginationParams = {
        from: 0,
        size: 40
      };
    }
    Question.query(paginationParams, function(questions) {
      console.log(questions);
      return delay.resolve(questions);
    }, function() {
      return delay.reject("Unable to fetch questions!");
    });
    return delay.promise;
  };
}).factory('QuestionLoader', function(Question, $route, $q) {
  return function() {
    var delay;
    delay = $q.defer();
    Question.get({
      id: $route.current.params.id
    }, function(question) {
      return delay.resolve(question);
    }, function() {
      return delay.reject("Unable to fetch question. " + $route.current.params.id);
    });
    return delay.promise;
  };
});
