'use strict';
angular.module('questionApp').factory('FormMetadata', function() {
  var meta;
  meta = {
    writers: [
      {
        writer_id: '?',
        name: "All"
      }, {
        writer_id: 1,
        name: "Maureen Sherlock"
      }, {
        writer_id: 2,
        name: "David Poltorak"
      }, {
        writer_id: 3,
        name: "Graeme Rickerby"
      }
    ],
    categories: [
      {
        category_id: '?',
        name: "All"
      }, {
        category_id: 1,
        name: "Sport"
      }, {
        category_id: 2,
        name: "Music"
      }, {
        category_id: 3,
        name: "Pot Luck"
      }, {
        category_id: 4,
        name: "Food"
      }, {
        category_id: 5,
        name: "History"
      }, {
        category_id: 6,
        name: "Current Affairs"
      }, {
        category_id: 7,
        name: "Movies"
      }, {
        category_id: 8,
        name: "TV"
      }, {
        category_id: 9,
        name: "Geography"
      }, {
        category_id: 10,
        name: "Pop Culture"
      }, {
        category_id: 11,
        name: "Science"
      }, {
        category_id: 12,
        name: "Theatre"
      }, {
        category_id: 13,
        name: "Literature"
      }, {
        category_id: 14,
        name: "Natural World"
      }, {
        category_id: 15,
        name: "Art"
      }, {
        category_id: 16,
        name: "Technology"
      }
    ],
    difficulties: [
      {
        difficulty_id: 1,
        name: "Easy"
      }, {
        difficulty_id: 2,
        name: "Medium"
      }, {
        difficulty_id: 3,
        name: "Hard"
      }
    ],
    question_types: [
      {
        value: "?",
        name: "All",
        question_type_id: "?"
      }, {
        value: false,
        name: "Single Choice",
        question_type_id: 1
      }, {
        value: true,
        name: "Multiple Choice",
        question_type_id: 2
      }
    ],
    producers: [
      {
        producer_id: 1,
        name: "Rob Menzies"
      }, {
        producer_id: 2,
        name: "Graeme Rickerby"
      }, {
        producer_id: 3,
        name: "Riima Daher"
      }
    ],
    verified_options: [
      {
        name: "All",
        value: "?"
      }, {
        name: "Verified",
        value: true
      }, {
        name: "Un-verified",
        value: false
      }
    ]
  };
  return {
    metafy: function(scope) {
      return _.assign(scope, meta);
    }
  };
});
