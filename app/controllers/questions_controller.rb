Tire.configure { logger 'elasticsearch.log', :level => 'debug' }

class QuestionsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter      :authenticate_user! # TODO: This should be set by cookies
  before_filter      :get_question, only: [:show, :edit, :update, :destroy, :remove_from_round]

  def index
    @questions = Question.search(params)
    @total     = @questions.total
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(params[:question])
    require 'pp'
    pp ['question', @question]

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
    if params[:used] == false
      @question.round = nil
    end
    if @question.update_attributes(params[:question])
      render :show
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @question.destroy
    sleep 1 # TODO - Why isn't the elastic search index updating correctly without a sleep?
    render json: { notice: "Question: #{@question.question}, deleted successfully." }
  end

  def number_available
    render json: { available: Question.available.count }
  end

  def remove_from_round
    @question.remove_from_round!
    render json: { notice: "Question: #{@question.question}, removed from round successfully." }
  end

  private

  def get_question
    @question = Question.find(params[:id])
  end
end
