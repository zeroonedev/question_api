class QuestionsController < CorsController

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(params[:question])
    if @question.valid?
      render :show
    else
      render :new
    end
  end

end
