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
      "writer_reference_2"=>"writer reference two",
      "is_multi" => false
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
     :writer_id,
     :writer_reference_1,
     :writer_reference_2
    ].each do |field|
      it "should not be valid without #{field}" do

        @question.send("#{field.to_s}=".to_sym, nil)
        @question.save
        if field == :question
          p @question.is_multi
          p @question.valid?
        end
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

  describe "multi-choice questions" do

    before(:each) do
      @params = {"question"=>{
        "is_multi"=>true, 
        "category_id"=>5, 
        "writer_id"=>2, 
        "difficulty_id"=>1,
        "batch_tag" => "SMH", 
        "question"=>"What year did Britain declare Wolrd War 2 on Gemany?", 
        "answer_a"=>"1938", "answer_b"=>"1945", "answer_c"=>"1939", "correct_answer"=>"C", 
        "extra_info"=>"ex info", "writer_reference_1"=>"foobar", "writer_reference_2"=>"yes"}
      }
    end

    it "should be valid" do
      question = Question.create(@params['question'])
      expect(question).to be_valid
    end
  end


end