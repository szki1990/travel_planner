class ChangePriceNullOnCosts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :costs, :price, true
  end
end
