class AddPurchaseItemToCosts < ActiveRecord::Migration[6.1]
  def change
    add_column :costs, :purchase_item, :string
  end
end
