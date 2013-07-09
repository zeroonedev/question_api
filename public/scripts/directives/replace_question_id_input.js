'use strict';
angular.module('questionApp').directive('replaceQuestionIdInput', function() {
  return {
    restrict: 'A',
    link: function(scope, element, attrs) {
      return scope.replacementQuestion = {};
    }
  };
});
