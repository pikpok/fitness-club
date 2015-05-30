class CreateScheduleEntries < ActiveRecord::Migration
  def change
    create_table :schedule_entries do |t|
      t.string :title
      t.string :trainer
      t.text :description
      t.integer :weekday
      t.time :start_time
      t.time :end_time

      t.timestamps null: false
    end
  end
end
