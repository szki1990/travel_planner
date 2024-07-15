class AddCheckListIdToCategories < ActiveRecord::Migration[6.1]
  def change
    add_reference :categories, :check_list, null: false, foreign_key: true
  end
end
