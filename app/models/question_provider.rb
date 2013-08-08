class QuestionProvider

  attr_reader :allocated_questions

  def initialize
    @allocated_questions = []
  end

  def allocated_question_ids
    ids = @allocated_questions.map(&:id)
    ids.empty? ? ["x", "y", "z"] : ids
  end

  def questions_for(params)
    limit = params[:limit]
    question_class = params[:spare] ? SpareQuestion : Question
    questions = question_class.where(question_type_id: question_type(params[:type])).where("id NOT IN (?)", allocated_question_ids).limit(limit)
    raise "hell: #{limit} != #{questions.count}" if limit != questions.count
    allocate(questions)
    questions
  end

  private

  def allocate questions
    @allocated_questions.concat(questions)
  end

  def question_type type_param
    QuestionType.find_by_name(type_param)
  end
end
