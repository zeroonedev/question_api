class Round < ActiveRecord::Base
  attr_accessible :name, :type

  belongs_to :type, :class_name => "RoundType", :foreign_key => "type_id"

  belongs_to :episode

  has_many :questions, :class_name => Question, conditions: proc { "spare_id is NULL" }, order: "position"
  has_many :spares,    :class_name => SpareQuestion, foreign_key: :spare_id, conditions: proc { "spare_id is not NULL" }, order: "position"

  before_destroy :remove_relationship_to_questions_and_spares

  def populate question_provider
    raise "ProvderError: Cannot perform populate without QuestionProvider" if question_provider.nil? 
    question_populate(question_provider)
    spare_populate(question_provider)
    self.save
  end

  def question_populate question_provider
    question_provider.questions_for({limit: type.number_of_questions, type: type.question_type.name}).each do |q|
     q.used = true
     raise "Question #{q.id} already associated with round" if q.round_id
     q.update_attributes! round_id: self.id, spare_id: nil
     #questions << q
    end
    raise "something fucked up here in questions" if self.questions.count != type.number_of_questions
  end

  def spare_populate question_provider
    question_provider.questions_for({limit: type.number_of_spares, type: type.question_type.name, spare: true}).each do |s|
      s.used = true
      raise "Question #{s.id} already associated with round" if s.round_id
      s.update_attributes! round_id: nil, spare_id: self.id
      #spares << s
    end
    raise "something fucked up here in spares" if self.spares.count != type.number_of_spares
  end

private
  def remove_relationship_to_questions_and_spares
    Question.update_all "used = null, round_id = null, spare_id = null", "round_id = #{self.id}"
  end

end
