require 'spec_helper'

describe "Question.search" do

  before(:each) do
    `mysql -u root -D question_api_test < db/test_question_data/question-db.sql`
    `RAILS_ENV=test rake environment tire:import CLASS='Question'`
    p "begin test"
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  def offset page, size
    total = Math.ceil(hits / request.size)
    total = total === 0 ? 1 : total
    current = Math.ceil((request.from / request.size) + 1)
  end

  it "returns good things" do

    [0, 1, 2, 3].each do |page|
      questions = Question.search(
        { from: 0 ,  size: 20 }
      )
      expect(questions.total).to eql(1619)
      expect(questions.count).to eql(20)
      
    end

    pool = []

    questions0 = Question.search({
        query: "DP0001", from: offset(0, 20),  size: 20 
    }).map(&:id).sort
    
    questions1 = Question.search({
        query: "DP0001", from: offset(1, 20) ,  size: 20 
    }).map(&:id).sort


    questions2 = Question.search({
        query: "DP0001", from: offset(2, 20) ,  size: 20 
    }).map(&:id).sort

    questions3 = Question.search({
        query: "DP0001", from: 61 ,  size: 20 
    }).map(&:id).sort

    questionsAll = Question.search(
      { query: "DP0001", from: 0 ,  size: 100 }
    ).map(&:id).sort

    expect(questions0 & questions1).to eql([])
    expect(questions0 & questions2).to eql([])
    expect(questions0 & questions3).to eql([])

    expect(questions1 & questions0).to eql([])
    expect(questions1 & questions2).to eql([])
    expect(questions1 & questions3).to eql([])

    expect(questions2 & questions0).to eql([])
    expect(questions2 & questions1).to eql([])
    expect(questions2 & questions3).to eql([])

    expect(questions3 & questions0).to eql([])
    expect(questions3 & questions1).to eql([])
    expect(questions3 & questions2).to eql([])

    expect(questionsAll.count).to eql(78)

  end

  # it "should return 78 quiestions for batch DP0001" do
  #   [0, 1, 2, 3].each do |page|
  #     questions = Question.search({
  #       "from"=>page, "query"=>"DP0001", "size"=>"20"
  #     })
  #     expect(questions.total).to eq 78
  #     p questions.map(&:id)
  #   end

  # end


end