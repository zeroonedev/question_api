'use strict';
angular.module('questionApp').controller('NewQuestionFormCtrl', function($scope, Question, $resource, $location, FormMetadata) {
  $scope = FormMetadata.metafy($scope);
  $scope.question = {};
  return $scope.saveQuestion = function() {
    delete $scope.question.errors;
    return Question.save({
      question: $scope.question
    }, function(data) {
      console.log(data);
      if (_.isEmpty(data.errors)) {
        return $location.url("questions");
      } else {
        return $scope.question = data;
      }
    });
  };
});
