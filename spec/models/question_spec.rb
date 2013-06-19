require 'spec_helper'

describe Question do


  describe "single answer question" do

    before(:each) do
      @question = Question.new(
        "question"=>"Why did the chicken cross the road", 
        "answer"=>"To get to the other side.", 
        "batch_tag"=>"XYZ", 
        "category_id"=>"4", 
        "difficulty_id"=>"2",
        "extra_info"=>"crazy chickens man",
        "producer_id"=>"3",
        "writer_id"=>"3",
        "writer_reference_1"=>"writer reference one", 
        "writer_reference_2"=>"writer reference two"
      )
    end

    it "should be valid" do
      @question.save
      @question.should be_valid
    end

    it "should not be valid without an answer" do
      @question.answer = nil
      @question.save
      @question.should_not be_valid
    end

  end

end