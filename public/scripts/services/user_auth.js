'use strict';
angular.module('questionApp').factory('UserAuth', function($resource) {
  return $resource("http://localhost:port/users/sign_in.json", {
    port: ':3000'
  });
});
