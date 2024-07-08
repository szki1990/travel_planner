class ChangePriceNullFalseOnCosts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :costs, :price, false
  end
end
