class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.integer :enviroment
      t.integer :service
      t.string :food_text
      t.integer :price
      t.text :comment

      t.timestamps
    end
  end
end
