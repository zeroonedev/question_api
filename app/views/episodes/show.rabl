object @episode

attributes :rx_number,
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
               :correct_answer

    child :category, object_root: false do
      attributes :id
                 :name
    end
  end
end