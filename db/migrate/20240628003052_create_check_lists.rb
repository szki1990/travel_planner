class CreateCheckLists < ActiveRecord::Migration[6.1]
  def change
    create_table :check_lists do |t|
      t.string :title, null: false
      t.timestamps
    end
  end
end
