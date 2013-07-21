FactoryGirl.define do
  factory :user do
  end

  factory :writer_user, class: User do
    name "Adam Jones"
    email "adamj@example.com"
    password "password123"
    association :role, factory: :role_writer
  end



end