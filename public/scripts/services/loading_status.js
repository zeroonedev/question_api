angular.module("loadingStatus", []).config(function($httpProvider) {
  return $httpProvider.interceptors.push("loadingStatusInterceptor");
}).directive("loadingStatusMessage", function() {
  return {
    link: function($scope, $element, attrs) {
      var hide, show;
      show = function() {
        return $element.css("display", "block");
      };
      hide = function() {
        return $element.css("display", "none");
      };
      $scope.$on("loadingStatusActive", show);
      $scope.$on("loadingStatusInactive", hide);
      return hide();
    }
  };
}).factory("loadingStatusInterceptor", function($q, $rootScope) {
  var activeRequests, ended, started;
  activeRequests = 0;
  started = function() {
    if (activeRequests === 0) {
      $rootScope.$broadcast("loadingStatusActive");
    }
    return activeRequests++;
  };
  ended = function() {
    activeRequests--;
    if (activeRequests === 0) {
      return $rootScope.$broadcast("loadingStatusInactive");
    }
  };
  return {
    request: function(config) {
      started();
      return config || $q.when(config);
    },
    response: function(response) {
      ended();
      if (response.config.url) {
        return response || $q.when(response);
      }
    },
    responseError: function(rejection) {
      ended();
      console.log(rejection);
      return $q.reject(rejection);
    }
  };
});
