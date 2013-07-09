'use strict';
angular.module('questionApp').config(function($routeProvider) {
  return $routeProvider.when('/questions', {
    controller: 'QuestionsCtrl',
    resolve: {
      questions: function(QuestionsLoader) {
        return QuestionsLoader();
      }
    },
    templateUrl: 'views/questions/index.html'
  }).when('/questions/new', {
    templateUrl: 'views/questions/new.html',
    controller: 'NewQuestionFormCtrl'
  }).when('/questions/edit/:id', {
    templateUrl: 'views/questions/edit.html',
    controller: 'EditQuestionFormCtrl',
    resolve: {
      question: function(QuestionLoader) {
        return QuestionLoader();
      }
    }
  }).when('/episodes/edit/:id', {
    templateUrl: 'views/episodes/edit.html',
    controller: 'EpisodesCtrl'
  }).when('/episodes/new', {
    templateUrl: 'views/episodes/new.html',
    controller: 'EpisodesCtrl'
  }).when('/episodes', {
    templateUrl: 'views/episodes/index.html',
    controller: 'EpisodesCtrl'
  }).otherwise({
    redirectTo: '/login'
  });
});
