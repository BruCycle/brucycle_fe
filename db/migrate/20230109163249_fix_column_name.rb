class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :strava_id, :strava_uid
  end
end
