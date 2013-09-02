
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
                  :answer_a,
                  :answer_b,
                  :answer_c,
                  :correct_answer,
                  :question_type_id,
                  :notes

  validates_presence_of :question,
                        :batch_tag,
                        :category_id,
                        :difficulty_id,
                        :writer_id,
                        :writer_reference_1,
                        :writer_reference_2,
                        :question_type_id

  validates_uniqueness_of :question

  validates :question, length: { maximum: 82 }
  validates :answer,   length: { maximum: 33 }
  validates :answer_a, length: { maximum: 33 }
  validates :answer_b, length: { maximum: 33 }
  validates :answer_c, length: { maximum: 33 }


  validates_with QuestionTypeValidator

  belongs_to :writer
  belongs_to :producer
  belongs_to :category
  belongs_to :difficulty
  belongs_to :question_type
  belongs_to :episode
  belongs_to :round

  scope :verified, -> { where(verified: true) }

  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id,               type: 'integer', index: 'not_analyzed'
    indexes :question
    indexes :answer
    indexes :answer_a
    indexes :answer_b
    indexes :answer_c
    indexes :batch_tag,        type: 'string', index: 'not_analyzed'
    indexes :writer_id,        type: 'integer'
    indexes :category_id,      type: 'integer'
    indexes :question_type_id, type: 'integer'
    indexes :difficulty_id,    type: 'integer'
    indexes :is_multi,         type: 'boolean'
    indexes :verified,         type: 'boolean'
    indexes :used,             type: 'boolean'
    indexes :updated_at,       type: 'date'
  end

  after_save do
    tire.update_index
  end

  after_destroy do
    tire.update_index
  end

  def self.search(params)

    tire.search(load: true, default_opertor: "AND", match_all: {}) do |s|
      s.size params[:size].present? ? params[:size] : self.all.count
      s.from params[:from] if params[:from].present?
      # s.sort  { by :updated_at, "desc" } if params[:query].blank?
      # s.sort  { by :id, params[:sort] }  if params[:sort].preset?
      s.query { string params[:query]  } if params[:query].present?

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

      s.filter :term, batch_tag: params[:batch_tag] if params[:batch_tag].present?
      s.facet "batch_tag" do
        terms :batch_tag
      end

      s.filter :term, question_type_id: params[:question_type_id] if params[:question_type_id].present?
      s.facet "question_type" do
        terms :question_type_id
      end
    end
  end

  def self.batch_tags
    verified.map{|q| { name: q.batch_tag, id: q.batch_tag } }.uniq
  end

  # TODO: make this less crazy
  def sanitize_errors
    errors.messages.map{|k, v| {k => v.join(" ")}  }.reduce({}){|memo, error| memo.merge!(error) }
  end

  def demote
    SpareQuestion.find(id).save!
  end

  def is_multi
    question_type == QuestionType.multi
  end

  def self.available
      where("used is null or used is not true")
  end

  def self.search_available params
      cid = params['category_id']
      did = params['difficulty_id']
      result = available
      result = where category_id:   cid unless "#{cid}".empty?
      result = where difficulty_id: did unless "#{did}".empty?
      result
  end
end
