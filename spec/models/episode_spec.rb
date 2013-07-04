require 'spec_helper'

def round_for_name episode, name
  episode.rounds.detect do |round|
    round.name == name
  end
end

def episode_hash episode
  hash = episode.attributes
  hash[:rounds] << @episode.rounds.reduce([]) do |memo, round|
    round_hash = round.attributes
    round_hash[:type] = round.type.attributes
    round_hash[:questions] = round.questions.map(&:attributes)
    round_hash[:spares] = round.spares.map(&:attributes)
    memo.push(round_hash) unless memo.nil?
  end
  hash
end

describe Episode do
  
  before(:each) do
    seed_meta_data
    @episode = Episode.generate(
      rx_number: "RX-21",
      record_date: 5.days.from_now.to_date.to_s(:db)
    )
  end

  describe "generate" do

    it "should have a total of 5 rounds" do
      expect(@episode.rounds.count).to eq 5
    end

    describe "standard rounds" do

      ["Round 1", "Round 2", "Round 3"].each do |round_name|
        
        describe "should build round: #{round_name}" do

          before(:each) do
            @round = round_for_name(@episode, round_name)
          end

          it "should build round with the sandard type" do
            expect(@round.type.name).to eq "Standard"
          end

          it "should have round type with single choice questions" do
            expect(@round.type.question_type.name).to eq "Single Choice"
          end

          it "should round type with 10 questions" do
            expect(@round.type.number_of_questions).to eq 10
          end

          it "should round_type 3 spare questions" do
            expect(@round.type.number_of_spares).to eq 3
          end
        end

      end

      describe "Double Points Round" do

        before(:each) do
          @round = round_for_name(@episode, "Double Points")
        end

        it "should have the round type of 'double points'" do
          expect(@round.type.name).to eq "Double"
        end

        it "should have round type with single choice questions" do
          expect(@round.type.question_type.name).to eq "Single Choice"  
        end

        it "should have round type with 20 questions" do
          expect(@round.type.number_of_questions).to eq 20
        end

        it "should have round type with 3 spare questions" do
          expect(@round.type.number_of_spares).to eq 3
        end
      end

      describe "End Game Round" do

        before(:each) do
          @round = round_for_name(@episode, "End Game")
        end

        it "should have round type of 'End Game'" do
          expect(@round.type.name).to eq "End"
        end

        it "should have round type with multi choice questions" do
          expect(@round.type.question_type.name).to eq "Multi Choice"  
        end

        it "should have round type with 6 questions" do
          expect(@round.type.number_of_questions).to eq 6
        end

        it "should have round type with 3 spare questions" do
          expect(@round.type.number_of_spares).to eq 3
        end

      end

    end

    describe "View Structure" do

      it "should render hash or json structure" do
        
        @episode

      end
    end

######

    describe "#populate" do

      describe "populate episode with questions" do

        before(:each) do
          import_questions
          @provider = QuestionProvider.new
          @episode.populate(@provider)
        end


        it "should description" do
          
          pp @episode.pretty_print

        end
        describe "Round 1" do

          before(:each) do
            @round = @episode.rounds.detect {|r| r.name == "Round 1" }
          end

          it "should have 10 questions" do
            expect(@round.questions.count).to eq 10
          end

          it "should have 3 spares" do
            expect(@round.spares.count).to eq 3
          end

        end

      end


      describe "questions are unique within and episode" do

        it "should fail to add same to episode" do
          
        end
      end

    end

#####

  end

end
