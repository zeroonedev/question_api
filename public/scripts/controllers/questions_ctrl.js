'use strict';
var services;

services = angular.module('questionApp').controller('QuestionsCtrl', function($scope, questions, $filter, $location, Question, FormMetadata, SearchMetadata) {
  $scope.setTitle("Question");
  
  $scope.setPage = function (pageNo) {
    $scope.currentPage = pageNo;
    $scope.searchQuery.from = pageNo;
    $scope.searchQuery.size = $scope.maxSize;
    console.log($scope.searchQuery)
    $scope.search(); 
  };

  $scope.noOfPages = SearchMetadata.numberOfPages();
  $scope.currentPage = 1;
  $scope.maxSize = SearchMetadata.maxSize();

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
