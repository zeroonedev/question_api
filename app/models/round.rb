class Round < ActiveRecord::Base
  attr_accessible :name, :type

  belongs_to :type, :class_name => "RoundType", :foreign_key => "type_id"
  
  belongs_to :episode



  has_many :questions, :class_name => Question, conditions: proc { "spare_id is NULL" }
  has_many :spares,    :class_name => SpareQuestion, foreign_key: :spare_id, conditions: proc { "spare_id is not NULL" }

  # expects a queston_provider 
  def populate question_provider
    raise "ProvderError: Cannot perform populate without QuestionProvider" if question_provider.nil? 
    question_populate(question_provider)
    spare_populate(question_provider)
    self.save
  end

  def question_populate question_provider
    p RoundType.all
    p type
    p type.question_type_id
    question_provider.questions_for({limit: type.number_of_questions, type: type.question_type.name}).each do |q|
     questions << q
    end
    # pp questions.map(&:question)
  end

  def spare_populate question_provider
    question_provider.questions_for({limit: type.number_of_spares, type: type.question_type.name, spare: true}).each do |s|
      spares << s
    end
    # pp spares.map(&:question)
  end



end
