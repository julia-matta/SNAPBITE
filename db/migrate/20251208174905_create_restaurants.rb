class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :category
      t.string :infos

      t.timestamps
    end
  end
end
