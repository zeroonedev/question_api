'use strict';
angular.module('questionApp').directive('multiChoiceToggle', function() {
  return {
    restrict: 'E',
    templateUrl: '/scripts/directives/multi_choice_toggle/template.html',
    replace: false,
    transclude: true,
    link: function(scope, element, attrs) {
      $('#multi-choice-block').hide();
      return scope.$watch('question.is_multi', function() {
        if (scope.question.is_multi) {
          $('#single-answer-block').hide();
          return $('#multi-choice-block').show();
        } else {
          $('#single-answer-block').show();
          return $('#multi-choice-block').hide();
        }
      });
    }
  };
});
