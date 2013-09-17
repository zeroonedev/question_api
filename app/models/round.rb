class Round < ActiveRecord::Base
  attr_accessible :name, :type

  belongs_to :type, :class_name => "RoundType", :foreign_key => "type_id"

  belongs_to :episode

  has_many :questions, :class_name => Question, conditions: proc { "spare_id is NULL" }, order: "position"
  has_many :spares,    :class_name => SpareQuestion, foreign_key: :spare_id, conditions: proc { "spare_id is not NULL" }, order: "position"

  def populate question_provider
    raise "ProvderError: Cannot perform populate without QuestionProvider" if question_provider.nil? 
    question_populate(question_provider)
    spare_populate(question_provider)
    self.save
  end

  def question_populate question_provider
    question_provider.questions_for({limit: type.number_of_questions, type: type.question_type.name}).each do |q|
     q.used = true
     questions << q
    end
  end

  def spare_populate question_provider
    question_provider.questions_for({limit: type.number_of_spares, type: type.question_type.name, spare: true}).each do |s|
      s.used = true
      spares << s
    end
  end
end
