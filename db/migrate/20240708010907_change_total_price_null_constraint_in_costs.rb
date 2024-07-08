class ChangeTotalPriceNullConstraintInCosts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :costs, :total_price, true
  end
end
