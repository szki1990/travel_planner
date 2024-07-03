class AddBookIdToCheckList < ActiveRecord::Migration[6.1]
  def change
    add_reference :check_lists, :book, null: false, foreign_key: true
  end
end
