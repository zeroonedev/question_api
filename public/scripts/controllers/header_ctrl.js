'use strict';
angular.module('questionApp').controller('HeaderCtrl', function($scope, $rootScope) {
  return $rootScope.setTitle = function(title) {
    return $scope.title = title;
  };
});
