'use strict';
angular.module('questionApp').controller('EditQuestionFormCtrl', function($scope, question, Question, FormMetadata, $route, $location, $filter) {
  var cleanedQuestion, restCleaner;
  $scope = FormMetadata.metafy($scope);
  restCleaner = $filter('questionRestCleaner');
  cleanedQuestion = restCleaner(question);
  $scope.question = cleanedQuestion;
  console.log($scope.question);
  return $scope.saveQuestion = function() {
    delete $scope.question.errors;
    return Question.update({
      id: $route.current.params.id,
      question: $scope.question
    }, function(question) {
      console.log(question);
      if (_.isEmpty(question.errors)) {
        $scope.message = "Question: " + question.id + " update successfully";
        return $location.url("questions/edit/" + question.id);
      } else {
        return $scope.question = question;
      }
    });
  };
});
