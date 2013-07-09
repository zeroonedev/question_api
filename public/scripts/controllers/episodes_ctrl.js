'use strict';
angular.module('questionApp').controller('EpisodesCtrl', function($scope, $location, $routeParams, FormMetadata, Episode, Question, $rootScope) {
  $rootScope.title = "Search Questions";
  $scope = FormMetadata.metafy($scope);
  $scope.replacementQuestions = {};
  $scope.newQuestion = {};
  $scope.episodes = Episode.all();
  $scope.episode = Episode.find($routeParams.id);
  $scope.generateEpisode = function() {
    console.log($scope.episode);
    return Episode.save($scope.episode, function(newEpisode) {
      console.log(newEpisode);
      return $scope.episode = newEpisode;
    });
  };
  $scope.deleteEpisode = function(episode) {
    return episode.$delete();
  };
  return $scope.replaceQuestion = function(current_id) {
    var search_id;
    search_id = $scope.replacementQuestions[current_id];
    if (search_id) {
      return $scope.idSearchResult = Question.get({
        id: search_id
      });
    }
  };
});
