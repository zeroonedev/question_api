# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :episode do
    rx_number "RX21"
    record_date 1.days.from_now.to_date.to_s(:db)   
  end

end
