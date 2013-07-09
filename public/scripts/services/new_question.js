'use strict';
angular.module('questionApp').factory('newQuestion', function() {
  var meaningOfLife;
  meaningOfLife = 42;
  return {
    someMethod: function() {
      return meaningOfLife;
    }
  };
});
