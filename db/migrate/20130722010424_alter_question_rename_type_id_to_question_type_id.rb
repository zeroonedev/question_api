class AlterQuestionRenameTypeIdToQuestionTypeId < ActiveRecord::Migration
  def up
    rename_column :questions, :type_id, :question_type_id
  end

  def down
    rename_column :questions, :question_type_id, :type_id
  end
end
