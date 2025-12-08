class AddRestaurantToRating < ActiveRecord::Migration[7.1]
  def change
    add_reference :ratings, :restaurant, null: false, foreign_key: true
  end
end
