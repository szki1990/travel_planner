class AddPublicToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :public, :boolean
  end
end
