class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :content, null: false
      t.timestamps
    end
  end
end
