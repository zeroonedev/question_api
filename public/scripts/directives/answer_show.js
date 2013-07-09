'use strict';
angular.module('questionApp').directive('answerShow', function() {
  return {
    templateUrl: '/scripts/directives/answer_show/template.html',
    restrict: 'E',
    link: function(scope, element, attrs) {}
  };
});
