angular.module('sharedServices', []).factory('SearchMetadata', function($rootScope) {
  $rootScope.searchMetaData = {};
  return {
    setTotalResults: function(results) {
      var total;
      if (results.length > 0) {
        total = results[0].total;
      }
      $rootScope.searchMetaData.totalResults = total;
      return console.log($rootScope.searchMetaData);
    },
    totalResults: function() {
      console.log("totalResults")
      return $rootScope.searchMetaData.totalResults;
    },
    setMaxSize: function(maxSize) {
      return $rootScope.searchMetaData.maxSize = maxSize;
    },
    maxSize: function() {
      return $rootScope.searchMetaData.maxSize;
    },
    setCurrentPage: function(page) {
      return $rootScope.searchMetaData.currentPage = page;
    },
    currentPage: function() {
      return $rootScope.searchMetaData.currentPage;
    },
    numberOfPages: function() {
      var num;
      num = $rootScope.searchMetaData.totalResults / $rootScope.searchMetaData.maxSize;
      console.log($rootScope)
      return num;
    },
    meta: function() {
      return $rootScope.searchMetaData;
    }
  };
});
