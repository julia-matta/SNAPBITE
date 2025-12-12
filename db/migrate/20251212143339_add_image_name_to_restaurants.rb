class AddImageNameToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :image_name, :string
  end
end
