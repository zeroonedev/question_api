class EpisodesController < CorsController

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

  def get_episode
    @episode ||= Episode.find(params[:id])
  end

end
