'use strict';
angular.module('questionApp').directive('question', function() {
  return {
    templateUrl: '/scripts/directives/question/template.html',
    restrict: 'E',
    link: function(scope, element, attrs) {}
  };
});
