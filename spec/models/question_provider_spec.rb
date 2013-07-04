require 'spec_helper'

describe QuestionProvider do

  before(:each) do
    seed_meta_data
    import_questions
    @provider = QuestionProvider.new

    @questions_for_params =   [ 
      { 
        type: "Single Choice",
        limit: 10
      },
      {
        type: "Single Choice",
        limit: 3
      },
      {
        type: "Multi Choice",
        limit: 6
      }
    ]

  end

  describe "allocated_questions" do
    it "should be empty by default" do
      expect(@provider.allocated_questions).to be_empty
    end
  end

  questions_for_params =   [ 
      { 
        type: "Single Choice",
        limit: 10
      },
      {
        type: "Single Choice",
        limit: 3,
        spare: true
      },
      {
        type: "Multi Choice",
        limit: 6
      }
    ]

  questions_for_params.each_with_index do |params, index|
    describe "#questions_for #{params}" do

      before(:each) do
        # p params
        @questions = @provider.questions_for(params)
      end

      it "should return 10 questions" do
        expect(@questions.count).to eq @questions_for_params[index][:limit]
      end

      it "should have 10 allocated_questions" do
        expect(@provider.allocated_questions.count).to eq @questions_for_params[index][:limit]
      end

      it "questions should be of type single choice" do
        expect(@questions.reject{|q| q.type.name == @questions_for_params[index][:type] }).to be_empty
      end

      it "should return the appropriate question class" do
        if params[:spare]
          expect(@questions.first.class.name).to eq "SpareQuestion"
        else
          expect(@questions.first.class.name).to eq "Question"
        end
      end

    end
  end

end