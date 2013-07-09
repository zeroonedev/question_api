'use strict';
angular.module('questionApp').filter('multiAnswersList', function() {
  return function(question) {
    var answers;
    answers = [];
    if (question.answer_a) {
      answers = _.map(["a", "b", "c"], function(tag) {
        var answer;
        answer = question["answer_" + tag];
        if (answer) {
          return "" + (tag.toUpperCase()) + ": " + (answer.toLowerCase());
        }
      });
      answers.push("Correct: " + question.correct_answer);
    }
    return answers.join(", ");
  };
});
