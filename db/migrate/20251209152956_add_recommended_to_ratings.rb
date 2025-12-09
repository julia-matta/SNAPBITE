class AddRecommendedToRatings < ActiveRecord::Migration[7.1]
  def change
    add_column :ratings, :recommended, :boolean, default: true
  end
end
