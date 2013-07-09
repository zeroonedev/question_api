'use strict';
angular.module('questionApp').controller('LoginCtrl', function($scope, UserAuth) {
  $scope.user = {};
  return $scope.authenticate = function() {
    console.log($scope.user);
    return UserAuth.save($scope.user, function(authResponse) {
      console.log(authResponse);
      return $scope.authError = authResponse.errors[0];
    });
  };
});
