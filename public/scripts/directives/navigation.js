'use strict';
angular.module('questionApp').directive('navigation', function() {
  return {
    templateUrl: '/scripts/directives/navigation/template.html',
    restrict: 'E',
    link: function(scope, element, attrs) {}
  };
});
