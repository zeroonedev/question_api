class QuestionsController < CorsController

  before_filter :get_question, only: [:show, :edit, :update]

  def index
    begin
      @questions = Question.search(params)
    rescue Exception => e
      @error = e
    end
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

  def update
    if @question.update_attributes(params[:question])
      render :show
    else
      render :edit
    end
  end

  def show
  end

  private

  def get_question
    @question = Question.find(params[:id])
  end

end
