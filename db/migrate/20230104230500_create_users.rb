class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :strava_id
      t.string :username
      t.string :firstname
      t.string :lastname
      t.string :photo_url
      t.timestamps
    end
  end
end
