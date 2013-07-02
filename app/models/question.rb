
class QuestionTypeValidator < ActiveModel::Validator

  def validate(record)
    if record.is_multi
      record.errors.add :answer_a, "can't be blank" if record.answer_a.blank? 
      record.errors.add :answer_b, "can't be blank" if record.answer_b.blank? 
      record.errors.add :answer_c, "can't be blank" if record.answer_c.blank? 
      record.errors.add :correct_answer, "can't be blank" if record.correct_answer.blank? 
    else
      record.errors.add :answer,  "can't be blank" if record.answer.blank? 
    end
  end

end

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
                  :is_multi,
                  :answer_a, 
                  :answer_b, 
                  :answer_c,
                  :correct_answer


  validates_inclusion_of :is_multi, :in => [true, false]
  validates_presence_of :question,
                        :batch_tag,
                        :category_id,
                        :difficulty_id,
                        :extra_info,
                        :writer_id,
                        :writer_reference_1,
                        :writer_reference_2

  validates_uniqueness_of :question

  validates_with QuestionTypeValidator
  
  belongs_to :writer
  belongs_to :producer
  belongs_to :category
  belongs_to :difficulty


  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id,          type: 'integer'
    indexes :question,    boost: 10
    indexes :answer,      boost: 9
    indexes :answer_a,    boost: 9
    indexes :answer_b,    boost: 9
    indexes :answer_c,    boost: 9
    indexes :batch_tag
    indexes :writer_id,   type: 'integer'
    indexes :category_id, type: 'integer'
    indexes :is_multi,    type: 'boolean'
    indexes :verified,    type: 'boolean'
    indexes :updated_at,  type: 'date'
  end
  
  def self.search(params)
    tire.search(load: true, default_opertor: "AND", match_all: {}) do |s|
      s.size self.all.count
      s.sort    { by :updated_at, "desc" } if params[:query].blank?
      s.query { string params[:query] } if params[:query].present?

      s.filter :term, is_multi: params[:is_multi] if params[:is_multi].present?
      s.facet "is_multi" do
        terms :is_multi
      end

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