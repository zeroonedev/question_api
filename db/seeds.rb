require 'conformist'
require 'csv'

question_schema = Conformist.new do
  column :question
  column :answer
  column :extra_info
  column :writer_reference_1 
  column :writer_reference_2 
  column :verifier_reference_1
  column :verifier_reference_2
  column :writer 
  column :batch_tag 
  column :difficulty
  column :category
  column :verified
  column :producer
  column :used
end

question_csv = CSV.open("db/test_question_data/question-answer.csv")

question_schema.conform(question_csv, :skip_first => true).each do |q|
    
  unless q.question.nil?
  
    writer_name = q.attributes.delete(:writer)
    producer_name = q.attributes.delete(:producer)
    category_name = q.attributes.delete(:category)
    difficulty_name = q.attributes.delete(:difficulty)

    writer = Writer.find_or_create_by_name(writer_name)
    producer = Producer.find_or_create_by_name(producer_name)
    category = Category.find_or_create_by_name(category_name)
    difficulty = Difficulty.find_or_create_by_name(difficulty_name)

    question = Question.new(q.attributes)

    question.writer = writer
    question.producer = producer
    question.category = category
    question.difficulty = difficulty

    question.save

    puts "saved ok" if question.valid?
    unless question.valid?
      p question.errors.messages
    end
  end

end

