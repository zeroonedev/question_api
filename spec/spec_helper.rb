# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| p f; require f }

extend FakeHelper

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  config.include FactoryGirl::Syntax::Methods
  config.include Rack::Test::Methods
  config.include JsonSpec::Helpers


  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

def import_questions
  Question.delete_all
  single_choice_schema = Conformist.new do
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

  multi_choice_schema = Conformist.new do
    column :question
    column :answer_a
    column :answer_b
    column :answer_c
    column :correct_answer
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

  csv_importer = {
    single_question_csv:  {
      file: CSV.open("db/test_question_data/real-data/QA_questions_final.csv"),
      schema: single_choice_schema,
      is_multi: false
    },
    multi_choice_csv: { 
      file: CSV.open("db/test_question_data/real-data/MC_questions_final.csv"),
      schema: multi_choice_schema,
      is_multi: true
    }
  }

  csv_importer.each do |key, value|
      
      schema = value[:schema]
      file = value[:file]
      is_multi = value[:is_multi]
      question_type = is_multi ? QuestionType.multi : QuestionType.single
 
    schema.conform(file, :skip_first => true).each do |q|
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
        question.question_type = question_type

        question.writer = writer
        question.producer = producer
        question.category = category
        question.difficulty = difficulty

        question.save


      end
    end
  end
end

def seed_meta_data
  [:round_type_standard, :round_type_double, :round_type_end].each do |round_type|
    create(round_type)
  end
  [:question_type_single, :question_type_multi].each do |type|
    create(type)
  end
end

# def fake_questions

#   10.times do
#     question, answer = FakeHelper::FakeQuestion.fabricate
#     p question
#     p answer
#     q = FactoryGirl.create(:question,
#       question:  question,
#       answer: answer
#     )
#     p q
#   end

# end

# def last_json
#   last_response.body
# end
