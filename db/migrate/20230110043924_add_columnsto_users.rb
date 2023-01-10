class AddColumnstoUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string
    add_column :users, :recent_beers, :integer
    add_column :users, :last_beer, :datetime
  end
end
