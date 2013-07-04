class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string  :question
      t.string  :answer
      t.string  :answer_a
      t.string  :answer_b
      t.string  :answer_c
      t.string  :correct_answer  
      t.string  :extra_info 
      t.string  :writer_reference_1
      t.string  :writer_reference_2 
      t.string  :batch_tag 
      t.string  :extra_info
      t.string  :tx_number
      t.string  :verifier_reference_1 
      t.string  :verifier_reference_2 
      t.string  :writer_reference_1 
      t.string  :writer_reference_2 
      t.integer :writer_id
      t.integer :category_id         
      t.integer :producer_id         
      t.integer :difficulty_id
      t.integer :type_id   
      t.integer :round_id
      t.integer :spare_id
      t.boolean :verified   
      t.boolean :used
      t.boolean :is_multi     
      t.timestamps
    end
  end
end
