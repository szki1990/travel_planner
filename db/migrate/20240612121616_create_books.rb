class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.datetime :start_day
      t.datetime :end_day
      t.timestamps
    end

    add_index :books, :title
  end
end
