require 'conformist'
require 'csv'

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
      file: CSV.open("db/test_question_data/question-answer.csv"),
      schema: single_choice_schema,
      is_multi: false
    },
    multi_choice_csv: { 
      file: CSV.open("db/test_question_data/question-multi-answer.csv"),
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

        q.attributes[:is_multi] = is_multi

        question = Question.new(q.attributes)

        p question_type
        
        question.type = question_type
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
  end
end

def meta_data

    meta = {
      writers: [
        { name: "Maureen Sherlock"},
        { name: "David Poltorak"},
        { name: "Graeme Rickerby"}
      ],
      categories: [
        { name: "Sport"},
        { name: "Music"},
        { name: "Pot Luck"},
        { name: "Food"},
        { name: "History"},
        { name: "Current Affairs"},
        { name: "Movies"},
        { name: "TV"},
        { name: "Geography"},
        { name: "Pop Culture"},
        { name: "Science"},
        { name: "Theatre"},
        { name: "Literature"},
        { name: "Natural World"},
        { name: "Art"},
        { name: "Technology"}
      ],
      difficulties: [
        { name:"Easy"},
        { name:"Medium"},
        { name:"Hard"}
      ],
      question_types: [
        { name: "Single Choice"  },
        { name: "Multi Choice" }
      ],
      producers: [
        { name: "Rob Menzies" },
        { name: "Graeme Rickerby" },
        { name: "Riima Daher" }
      ],
      rounds: [
        "Standard",
        "Double",
        "End"
      ]
    }

  QuestionType.delete_all
  meta[:question_types].each do |question_type|
    QuestionType.create(name: question_type[:name])
  end

  RoundType.delete_all
  [
    { name: "Standard", 
      number_of_questions: 10,
      number_of_spares: 3,
      question_type_id: QuestionType.single.id
    }, 
    { name: "Double", 
      number_of_questions: 20,
      number_of_spares: 3,
      question_type_id: QuestionType.single.id  
    },  
    { name: "End", 
      number_of_questions: 6,
      number_of_spares: 3,
      question_type_id: QuestionType.multi.id
    }
  ].each do |round_attributes|
    rt = RoundType.create(round_attributes)
    p rt
  end

end

meta_data
import_questions

`rake environment tire:import CLASS='Question'`



