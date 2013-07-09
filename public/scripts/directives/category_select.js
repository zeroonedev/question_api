'use strict';
angular.module('questionApp').directive('categorySelect', function() {
  return {
    templateUrl: '/scripts/directives/category_select/template.html',
    restrict: 'E',
    link: function(scope, element, attrs) {
      return console.log(attrs);
    }
  };
});
