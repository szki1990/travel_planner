class AddBookIdToCategories < ActiveRecord::Migration[6.1]
  def change
    # add_reference :categories, :book, null: false, foreign_key: true
  end
end
