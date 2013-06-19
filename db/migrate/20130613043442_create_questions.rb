class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string  :question
      t.string  :answer
      t.string  :answer_a
      t.string  :answer_b
      t.string  :answer_c  
      t.string  :extra_info 
      t.string  :writer_reference_1 
      t.string  :writer_reference_2 
      t.string  :batch_tag 
      t.string  :extra_info
      t.string  :tx_number
      t.string  :verifier_reference_1 
      t.string  :verifier_reference_2 
      t.string  :writer_id
      t.string  :writer_reference_1 
      t.string  :writer_reference_2 
      t.integer :category_id         
      t.integer :producer_id         
      t.integer :difficulty_id   
      t.boolean :verified   
      t.boolean :used         
      t.timestamps
    end
  end
end
