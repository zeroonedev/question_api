'use strict';
angular.module('questionApp').factory('Episode', function($resource) {
  var Episode;
  Episode = $resource("http://localhost:port/episodes/:id.json", {
    id: '@id',
    port: ':3000'
  });
  Episode.all = function() {
    return Episode.query();
  };
  Episode.find = function(id) {
    if (id) {
      return Episode.get({
        id: id
      });
    } else {
      return {};
    }
  };
  return Episode;
});
