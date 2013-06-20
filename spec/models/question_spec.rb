require 'spec_helper'

describe Question do

  before(:each) do

    @test_question_hash = {
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
    }

    @question = Question.new(
      @test_question_hash
    )
  end

  describe "validations" do

    it "should be valid" do
      @question.save
      @question.should be_valid
    end

    [
     :question, 
     :answer,
     :batch_tag,
     :category_id,
     :difficulty_id,
     :extra_info,
     :producer_id,
     :writer_id,
     :writer_reference_1,
     :writer_reference_2
    ].each do |field|
      it "should not be valid without #{field}" do
        @question.send("#{field.to_s}=".to_sym, nil)
        @question.save
        expect(@question).not_to be_valid
      end
    end

    it "should have unique question text" do
      @question.save
      @question2 = Question.new(
        @test_question_hash
      )
      @question2.save
      expect(@question2).to_not be_valid

    end

  end

end