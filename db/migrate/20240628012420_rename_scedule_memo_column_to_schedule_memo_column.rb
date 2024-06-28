class RenameSceduleMemoColumnToScheduleMemoColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :Schedules, :scedule_memo, :schedule_memo
  end
end
