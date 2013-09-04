require "continuation"

class EpisodesController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!
  before_filter :has_access

  def create
    @episode = Episode.generate(
      params[:episode]
    )
    @provider = QuestionProvider.new
    @episode.populate(@provider)
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
    sleep 1
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
          old_question       = Question.find( params['question_id'] )
          old_position       = old_question.position
          round              = old_question.round
          found              = Question.search_available params
          offset             = rand(found.count)
          new_question       = found.offset(offset).first
          cont.call success: false, error: "No replacement question found" unless new_question
          round.questions << new_question
          round.questions.delete old_question
          round.save!
          new_question.insert_at (old_position || 0)

          { success: true, question: new_question }
      end
      render json: result
  end

  def export_csv
    episode_id = params['id']

    response.headers["Content-Disposition"] = %{attachment; filename="episode-#{episode_id}.csv"}
    response.headers["Content-Type"]        = 'text/csv'

    send_data Episode.find(episode_id).to_csv, type: "text/plain", filename: "episode-#{episode_id}", disposition: 'attachment'
  end
end
