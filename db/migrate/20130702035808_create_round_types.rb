class CreateRoundTypes < ActiveRecord::Migration
  def change
    create_table :round_types do |t|
      t.string :name
      t.integer :question_type_id
      t.integer :number_of_questions
      t.integer :number_of_spares
      t.timestamps
    end
  end
end
