'use strict';
angular.module('questionApp').filter('decorateRounds', function() {
  return function(rounds) {
    return _.map(rounds, function(round) {
      return round;
    });
  };
});
