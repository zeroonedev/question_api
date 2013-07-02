require 'spec_helper'

describe Episode do
  
  before(:each) do
    @episode = Episode.new(
      rx_number: "RX-21",
      date: 5.days.from_now.to_date.to_s(:db)
    )
  end

  describe "create episode" do

    it "should create a rounds" do
      
    end

    it "should " do
      
    end
  end

end
