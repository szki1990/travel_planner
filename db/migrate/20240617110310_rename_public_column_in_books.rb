class RenamePublicColumnInBooks < ActiveRecord::Migration[6.1]
  def change
    rename_column :books, :public, :public_status
  end
end
