'use strict';
var services;

services = angular.module('questionApp').controller('QuestionsCtrl', function($scope, questions, $filter, $location, Question, FormMetadata, SearchMetadata) {
  $scope.setTitle("Question");
  $scope.searchMetadata = SearchMetadata.meta;
  $scope.setPage = function(pageNo) {
    $scope.searchMetadata.currentPage = pageNo;
    $scope.searchMetadata.searchQuery.from = $scope.currentPage;
    $scope.searchMetadata.searchQuery.size = $scope.maxSize;
    return $scope.search();
  };
  $scope.searchQuery = {};
  $scope.questions = questions;
  $scope = FormMetadata.metafy($scope);
  $scope.remove = function(index) {
    return $scope.questions.pop($scope.questions[index]);
  };
  $scope.editQuestion = function(id) {
    return $location.url("questions/edit/" + id);
  };
  return $scope.search = function() {
    var pruneSearchQuery;
    console.log($scope.searchQuery);
    pruneSearchQuery = $filter('pruneSearchQuery');
    $scope.searchQuery = pruneSearchQuery($scope.searchQuery);
    return Question.query($scope.searchQuery, function(data) {
      console.log(data);
      return $scope.questions = data;
    });
  };
});
