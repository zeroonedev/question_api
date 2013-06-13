class QuestionsController < CorsController

  def new
    render :json => Question.new
  end

  def create
    question = params[:question]
    render :json => question
  end

end
