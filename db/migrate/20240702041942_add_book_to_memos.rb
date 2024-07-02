class AddBookToMemos < ActiveRecord::Migration[6.1]
  def change
    add_reference :memos, :book, null: false, foreign_key: true
  end
end
