object @question

attributes :is_multi,
           :question,
           :answer,
           :answer_a,
           :answer_b,
           :answer_c,
           :correct_answer,
           :extra_info, 
           :writer_reference_1, 
           :writer_reference_2, 
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


node(:category) do |question|
  question.category.name if question.category
end

