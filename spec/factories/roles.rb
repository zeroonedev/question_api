# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role do
  end

  factory :role_writer, class: Role do
    name "Writer"
  end
  
end
