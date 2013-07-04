# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question_type do
  end

  factory :question_type_single, class: QuestionType do
    name "Single Choice"
  end
  factory :question_type_multi, class: QuestionType do
    name "Multi Choice"
  end
end
