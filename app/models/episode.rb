class Episode < ActiveRecord::Base

  attr_accessible :rx_number, :record_date

  validates_presence_of :rx_number,
                        :record_date

  has_many :rounds, :dependent => :destroy

  ROUND_METADATA = [
    {
      name: "Round 1",
      type: "Standard"
    },
        {
      name: "Round 2",
      type: "Standard"
    },
        {
      name: "Round 3",
      type: "Standard"
    },
        {
      name: "Double Points",
      type: "Double"
    },
    {
      name: "End Game",
      type: "End"
    },
  ]

  def self.generate attributes
    episode = Episode.create(attributes)
    ROUND_METADATA.each do |round_meta|
      round = Round.new(
        name: round_meta[:name],
        type: RoundType.find_by_name(round_meta[:type])
      )
      episode.rounds << round 
    end
    episode.save
    episode
  end

  def populate provider
    rounds.each do |round|
      round.populate provider
    end
  end

  def pretty_print
    hash = self.attributes
    hash[:rounds] = self.rounds.reduce([]) do |memo, round|
      round_hash = round.attributes
      round_hash[:type] = round.type.attributes
      round_hash[:questions] = round.questions.map(&:attributes)
      round_hash[:spares] = round.spares.map(&:attributes)
      memo.push(round_hash) unless memo.nil?
    end
    hash
  end

  def to_csv options = {}
    cns = Question.column_names
    CSV.generate(options) do |csv|
      csv << cns
      self.rounds.each do |round|
        round.questions.each do |question|
          csv << question.attributes.values_at(*cns)
        end
      end
    end
  end
end
