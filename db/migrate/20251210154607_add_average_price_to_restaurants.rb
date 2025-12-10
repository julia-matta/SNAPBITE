class AddAveragePriceToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :average_price, :integer
  end
end
