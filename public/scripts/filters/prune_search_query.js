'use strict';
angular.module('questionApp').filter('pruneSearchQuery', function() {
  return function(searchQuery) {
    if (searchQuery.type_id === "?") {
      delete searchQuery.type_id;
    }
    if (searchQuery.category_id === "?") {
      delete searchQuery.category_id;
    }
    if (searchQuery.writer_id === "?") {
      delete searchQuery.writer_id;
    }
    console.log(searchQuery);
    return searchQuery;
  };
});
