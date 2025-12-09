class AddScoreToRatings < ActiveRecord::Migration[7.1]
  def change
    add_column :ratings, :score, :integer
  end
end
