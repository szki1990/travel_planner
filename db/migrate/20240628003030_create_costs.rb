class CreateCosts < ActiveRecord::Migration[6.1]
  def change
    create_table :costs do |t|
      t.integer :price, null: false
      t.datetime :date, null: false
      t.string :remarks
      t.string :consumer, null: false
      t.integer :payment_method, null: false
      t.integer :total_price, null: false
      t.timestamps
    end
  end
end
