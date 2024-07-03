class AddBookIdToCosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :costs, :book, null: false, foreign_key: true
  end
end
