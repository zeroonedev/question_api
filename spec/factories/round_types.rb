# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :round_type do  
  end

  factory :round_type_standard, class: RoundType do
    name "Standard"
    number_of_questions 10
    number_of_spares 3
    association :question_type, factory: :question_type_single 
  end

  factory :round_type_double, class: RoundType do
    name "Double"
    number_of_questions 20
    number_of_spares 3
    association :question_type, factory: :question_type_single 
  end
  factory :round_type_end, class: RoundType do
    name "End"
    number_of_questions 6
    number_of_spares 3   
    association :question_type, factory: :question_type_multi 
  end
end
