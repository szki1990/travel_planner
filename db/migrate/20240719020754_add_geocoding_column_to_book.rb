class AddGeocodingColumnToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :address, :string, null: false, default: ""
    add_column :books, :latitude, :float, null: false, default: 0
    add_column :books, :longitude, :float, null: false, default: 0
  end
end
