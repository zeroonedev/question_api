require 'spec_helper'

describe Round do

  before(:each) do
    
    seed_meta_data
    
    import_questions 

   @round = Round.new(
      name: "Round 1",
      type: RoundType.find_by_name("Standard")
    )
  end

  describe "populate" do
      describe "questions for each round" do
      
        [
          {
            expected_name: "Round 1",
            expected_number_of_questions: 10,
            expected_number_of_spares: 3,
            expected_question_type: "Single Choice"
          },
          {
            expected_name: "Round 2",
            expected_number_of_questions: 10,
            expected_number_of_spares: 3,
            expected_question_type: "Single Choice"
          },
          {
            expected_name: "Round 2",
            expected_number_of_questions: 10,
            expected_number_of_spares: 3,
            expected_question_type: "Single Choice"
          },
          {
            expected_name: "Double Points",
            expected_number_of_questions: 20,
            expected_number_of_spares: 3,
            expected_question_type: "Single Choice"
          },
          {
            expected_name: "End Game",
            expected_number_of_questions: 6,
            expected_number_of_spares: 3,
            expected_question_type: "Multi Choice"
          }
        ].each do |attributes|

          describe "#{attributes[:expected_name]} should contain" do

            before(:each) do
              import_questions
              @episode = Episode.generate(
                rx_number: "RX-251",
                record_date: 5.days.from_now.to_date.to_s(:db)
              )
              @round = @episode.rounds.detect {|round| round.name == attributes[:expected_name] }
              @provider = QuestionProvider.new
              @round.populate(@provider)
            end

            it " a count of #{attributes[:expected_number_of_questions]} question objects" do
              expect(@round.questions.count).to eq attributes[:expected_number_of_questions]
            end

            it " a count of #{attributes[:expected_number_of_spares]} spare question objects" do
              expect(@round.spares.count).to eq attributes[:expected_number_of_spares]
            end            

          end

        end

      end
    end

end
