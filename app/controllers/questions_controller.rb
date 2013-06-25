class QuestionsController < CorsController

  before_filter :get_question, only: [:show, :edit]

  def index
    @questions = Question.search(params)
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

  def edit
  end

  def show
  end

  private

  def get_question
    @question = Question.find(params[:id])
  end

end
