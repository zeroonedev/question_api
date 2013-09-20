object @question

node :error if @error

attributes :question,
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
           :used,
           :verified,
           :verifier_reference_1,
           :verifier_reference_2,
           :writer_id,
           :writer_reference_1,
           :writer_reference_2,
           :notes,
           :question_type_id

child :round do
  attributes :id

  child :episode do
    attributes :id, :rx_number
  end
end


node(:category) do |question|
  question.category.name if question.category
end

