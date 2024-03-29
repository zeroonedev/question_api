require "continuation"

class EpisodesController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!
  before_filter :has_access

  def create
    ActiveRecord::Base.transaction do
      @episode = Episode.generate( params[:episode])
      @provider = QuestionProvider.new
      @episode.populate(@provider)

      @episode.rounds.each_with_index do |round, i|
        rqc = round.questions.count
        rtn = round.type.number_of_questions
        if rqc != rtn
          raise "Round #{i} [#{round.id}] of episode #{@episode.id} contains #{rqc} questions (Should have #{rtn})"
        end
      end
    end
    render :show
  end

  def show
    get_episode
  end

  def index
    @episodes = Episode.all
  end

  def destroy
    get_episode
    @message = { message: "Episode:#{@episode.rx_number} deleted successfully." }
    @episode.destroy
    sleep 1 # TODO: Figure out a way to avoid having to do this...
    render json: @message
  end

  def get_episode
    @episode ||= Episode.find(params[:id])
  end

  def has_access
    unless current_user.admin? || current_user.producer?
      respond_to do |format|
        format.html
        format.json { render json: "Forbidden", status: 403 }
      end
    end
  end

  def replace_question
      result = callcc do |cont|
          old_question  = Question.find( params['question_id'] )
          cont.call( json: { success: false, error: "Question not found" }) unless old_question

          round          = old_question.round
          cont.call( json: { success: false, error: "Round not found" }) unless round

          new_question = QuestionProvider.new.questions_for({limit: 1, type: round.type.question_type.name, spare: old_question.spare_id})
          new_question = new_question.where(difficulty_id: params[:difficulty_id]) if params[:difficulty_id]
          new_question = new_question.where(category_id:   params[:category_id])   if params[:category_id]
          new_question = new_question.first

          cont.call( json: { success: false, error: "No replacement question found" }) unless new_question

          old_position          = old_question.position
          new_question.round_id = old_question.round_id
          new_question.spare_id = old_question.spare_id
          new_question.position = old_question.position
          new_question.used     = true
          new_question.save! validate: false

          old_question.round_id = nil
          old_question.spare_id = nil
          old_question.position = nil
          old_question.save! validate: false

          { json: { success: true, question: new_question }}
      end
      render result
  end

  def export_csv
    episode_id = params['id']

    response.headers["Content-Disposition"] = %{attachment; filename="episode-#{episode_id}.csv"}
    response.headers["Content-Type"]        = 'text/csv'

    send_data Episode.find(episode_id).to_csv, type: "text/plain", filename: "episode-#{episode_id}", disposition: 'attachment'
  end
end
