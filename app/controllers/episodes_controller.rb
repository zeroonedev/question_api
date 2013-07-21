class EpisodesController < CorsController

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


end
