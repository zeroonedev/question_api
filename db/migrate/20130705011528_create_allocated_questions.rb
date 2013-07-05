class CreateAllocatedQuestions < ActiveRecord::Migration
  def change
    create_table :allocated_questions do |t|
      t.integer :question_id
      t.integer :round_id
      t.timestamps
    end
  end
end
