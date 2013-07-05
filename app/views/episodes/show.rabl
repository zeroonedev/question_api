object @episode

attributes :id,
           :rx_number,
           :record_date

child :rounds, object_root: false do
  attributes :name
  child :questions, object_root: false do
    attributes :id,
               :question, 
               :answer, 
               :answer_a, 
               :answer_b,
               :answer_c,
               :correct_answer,
               :category_id,
               :difficulty_id,
               :is_multi

    child :category, object_root: false do
      attribute  :id => :category_id
      attributes :name
    end
  end

  child :spares, object_root: false do
    attributes :id,
               :question, 
               :answer, 
               :answer_a, 
               :answer_b,
               :answer_c,
               :correct_answer,
               :category_id,
               :difficulty_id,
               :is_multi
  end

end