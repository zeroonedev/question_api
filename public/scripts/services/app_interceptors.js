angular.module("appInterceptors", ['sharedServices']).config(function($httpProvider) {
  return $httpProvider.interceptors.push("questionsInterceptor");
}).filter('extractPaginationData', function(SearchMetadata, $rootScope) {
  return function(response) {
    var questions;
    if (/questions.json/.test(response.config.url)) {
      questions = response.data;
      SearchMetadata.setCurrentPage(0);
      SearchMetadata.setMaxSize(20);
      SearchMetadata.setTotalResults(questions);
      return questions;
    }
  };
}).factory("questionsInterceptor", function($q, $filter) {
  return {
    request: function(config) {
      return config || $q.when(config);
    },
    response: function(response) {
      var extractPaginationData;
      if (/questions.json/.test(response.config.url)) {
        extractPaginationData = $filter('extractPaginationData');
        extractPaginationData(response);
      }
      if (response.config.url) {
        return response || $q.when(response);
      }
    },
    responseError: function(rejection) {
      return $q.reject(rejection);
    }
  };
});
