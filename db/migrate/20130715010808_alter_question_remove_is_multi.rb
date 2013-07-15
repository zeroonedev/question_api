class AlterQuestionRemoveIsMulti < ActiveRecord::Migration
  def up
    remove_column :questions, :is_multi
  end

  def down
    add_column :questions, :is_multi, :boolean
  end
end
