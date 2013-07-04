# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :round do
  end

  factory :round_one, class: Round do
    name "Round 1"
    association :type, factory: :round_type, name: "Standard"
  end
  
  factory :round_two, class: Round do
    name "Round 2"
    association :type, factory: :round_type, name: "Standard"
  end
  
  factory :round_three, class: Round do
    name "Round 3"
    association :type, factory: :round_type, name: "Standard"
  end
  
  factory :round_four, class: Round do
    name "Double Points"
    association :type, factory: :round_type, name: "Double"
  end
  
  factory :round_five, class: Round do
    name "End Game"
    association :type, factory: :round_type, name: "End"
  end

end
