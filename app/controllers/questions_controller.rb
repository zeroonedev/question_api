 Tire.configure { logger 'elasticsearch.log', :level => 'debug' }

class QuestionsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_question, only: [:show, :edit, :update]

  def index
    @questions = Question.search(params)
    @total =  @questions.total
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(params[:question])
    if @question.valid?
      render :show
      @notification = "Question '#{@question.question}' created successfully."
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

  def destroy
    get_question
    @question.destroy
    render json: { notice: "Question: @question.question, deleted successfully." }
  end

  private

  def get_question
    @question = Question.find(params[:id])
  end

end
