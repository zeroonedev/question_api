class Question < ActiveRecord::Base

  attr_accessible :answer_a, 
                  :answer_b, 
                  :answer_c, :batch_tag, 
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
                  :answer,
                  :created_at,
                  :updated_at

end
