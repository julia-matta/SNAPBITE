class AddCityToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :city, :string
  end
end
