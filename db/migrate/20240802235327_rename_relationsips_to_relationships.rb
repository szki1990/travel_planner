class RenameRelationsipsToRelationships < ActiveRecord::Migration[6.1]
  def change
    rename_table :relationsips, :relationships
  end
end
