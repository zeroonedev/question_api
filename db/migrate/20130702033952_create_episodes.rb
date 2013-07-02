class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :rx_number
      t.date :record_date
      t.timestamps
    end
  end
end
