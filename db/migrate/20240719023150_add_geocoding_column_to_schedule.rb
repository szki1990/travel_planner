class AddGeocodingColumnToSchedule < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :address, :string, null: false, default: ""
    add_column :schedules, :latitude, :float, null: false, default: 0
    add_column :schedules, :longitude, :float, null: false, default: 0
  end
end
