class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.string :title, null: false
      t.integer :budget
      t.string :place
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :start_time
      t.datetime :end_time
      t.text :schedule_memo
      t.timestamps
    end
  end
end
