class AddIconToschedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :icon, :string
  end
end
