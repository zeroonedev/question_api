
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
                  :correct_answer,
                  :type_id,
                  :notes


  # validates_inclusion_of :is_multi, :in => [true, false]
  validates_presence_of :question,
                        :batch_tag,
                        :category_id,
                        :difficulty_id,
                        :writer_id,
                        :writer_reference_1,
                        :writer_reference_2,
                        :type_id

  validates_uniqueness_of :question

  validates_with QuestionTypeValidator
  
  belongs_to :writer
  belongs_to :producer
  belongs_to :category
  belongs_to :difficulty
  belongs_to :type, class_name: QuestionType, :foreign_key => "type_id"


  scope :verified, -> { where(verified: true) }

  include Tire::Model::Search
  include Tire::Model::Callbacks

  after_save do
    update_index
  end

  mapping do
    indexes :id,               type: 'integer'
    indexes :question,         boost: 10
    indexes :answer,           boost: 9
    indexes :answer_a,         boost: 9
    indexes :answer_b,         boost: 9
    indexes :answer_c,         boost: 9
    indexes :batch_tag
    indexes :writer_id,        type: 'integer'
    indexes :category_id,      type: 'integer'
    indexes :type_id,          type: 'integer'
    indexes :difficulty_id,    type: 'integer'
    indexes :is_multi,         type: 'boolean'
    indexes :verified,         type: 'boolean'
    indexes :used,             type: 'boolean'
    indexes :updated_at,       type: 'date'
  end    
       
  def self.search(params)
    tire.search(load: true     , default_opertor: "AND", match_all: {}) do |s|
      s.size params[:size].present? ? params[:size] : self.all.count
      s.from params[:from] if params[:from].present?
      s.sort  { by :updated_at, "desc" } if params[:query].blank?
      s.query { string params[:query]  } if params[:query].present?

      s.filter :term, is_multi: params[:is_multi] if params[:is_multi].present? and 
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

      s.filter :term, difficulty_id: params[:difficulty_id] if params[:difficulty_id].present?
      s.facet "difficulty" do
        terms :difficulty_id
      end

      s.filter :term, verified: params[:verified] if params[:verified].present?
      s.facet "verified" do
        terms :verified
      end

      s.filter :term, used: params[:used] if params[:used].present?
      s.facet "used" do
        terms :used
      end

      s.filter :term, type_id: params[:type_id] if params[:type_id].present?
      s.facet "question_type" do
        terms :type_id
      end

    end
  end

  #TODO make this less crazy
  def sanitize_errors
    errors.messages.map{|k, v| {k => v.join(" ")}  }.reduce({}){|memo, error| memo.merge!(error) }
  end

  def demote
    SpareQuestion.find(id).save!
  end

end