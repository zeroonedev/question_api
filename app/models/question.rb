class Question < ActiveRecord::Base

  attr_accessible :batch_tag, 
                  :answer,
                  :category_id, 
                  :difficulty_id,
                  :extra_info, 
                  :id, 
                  :producer_id, 
                  :question, 
                  :tx_number, 
                  :used, 
                  :verified, 
                  :verifier_reference_1,
                  :verifier_reference_2, 
                  :writer_id, 
                  :writer_reference_1, 
                  :writer_reference_2, 
                  :created_at,
                  :updated_at,
                  :is_multi


  validates_presence_of :question, 
                        :answer,
                        :batch_tag,
                        :category_id,
                        :difficulty_id,
                        :extra_info,
                        :writer_id,
                        :writer_reference_1,
                        :writer_reference_2

  # validates_presence_if :answer_a, :answer_b, :answer_c :if => proc { |obj| obj.is_multi }}

  validates_uniqueness_of :question
  
  belongs_to :writer
  belongs_to :producer
  belongs_to :category
  belongs_to :difficulty


  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id, type: 'integer'
    indexes :question, boost: 10
    indexes :answer, boost: 9
    indexes :batch_tag
    indexes :writer_id, type: 'integer'
    indexes :category_id, type: 'integer'
  end
  
  def self.search(params)
    tire.search(load: true, default_opertor: "AND", match_all: {}) do |s|
      s.size self.all.count
      s.query { string params[:query] } if params[:query].present?
      s.filter :term, writer_id: params[:writer_id] if params[:writer_id].present?
      s.facet "writers" do
        terms :writer_id
      end
      s.filter :term, category_id: params[:category_id] if params[:category_id].present?
      s.facet "category" do
        terms :category_id
      end
    end
  end

  #TODO make this less crazy
  def sanitize_errors
    errors.messages.map{|k, v| {k => v.join(" ")}  }.reduce({}){|memo, error| memo.merge!(error) }
  end

end