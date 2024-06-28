class AddUserIdAndBookIdToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :user_id, :integer
    add_column :schedules, :book_id, :integer
  end
end
