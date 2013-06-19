class QuestionsController < CorsController

  def index
    @questions = Question.all
  end

  def new
    render :json => Question.new
  end

  def create
    question = Question.create(params[:question])
    render :json => question
  end

end
