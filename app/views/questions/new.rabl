object @question

node(:errors) { |question| 
  question.sanitize_errors 
}

attributes :question,
           :answer,
           :extra_info, 
           :writer_reference_1, 
           :writer_reference_2, 
           :answer, 
           :batch_tag, 
           :category_id, 
           :difficulty_id, 
           :extra_info, 
           :id, 
           :producer_id, 
           :tx_number, 
           :used,
           :verified, 
           :verifier_reference_1,
           :verifier_reference_2,
           :writer_id,
           :writer_reference_1,
           :writer_reference_2