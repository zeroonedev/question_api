class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :name
      t.integer :type_id
      t.integer :episode_id
      t.timestamps
    end
  end
end