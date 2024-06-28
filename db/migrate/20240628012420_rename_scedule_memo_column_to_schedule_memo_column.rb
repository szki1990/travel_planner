class RenameSceduleMemoColumnToScheduleMemoColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :schedules, :scedule_memo, :schedule_memo
  end
end
