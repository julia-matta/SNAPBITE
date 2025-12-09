class AddFieldsToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :address, :string
    add_column :restaurants, :opening_hours, :text
    add_column :restaurants, :price_range, :integer
  end
end
