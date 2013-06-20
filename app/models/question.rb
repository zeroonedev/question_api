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
                        :producer_id,
                        :writer_id,
                        :writer_reference_1,
                        :writer_reference_2

  # validates_presence_of :answer_a, :answer_b, :answer_c :if => proc { |obj| obj.is_multi }}

  validates_uniqueness_of :question
  
  #TODO make this less crazy
  def sanitize_errors
    errors.messages.map{|k, v| {k => v.first}  }.reduce({}){|memo, error| memo.merge!(error) }
  end

end
