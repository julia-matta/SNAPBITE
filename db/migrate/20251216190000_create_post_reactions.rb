class CreatePostReactions < ActiveRecord::Migration[7.1]
  def change
    create_table :post_reactions, if_not_exists: true do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.integer :reaction_type, null: false

      t.timestamps
    end

    add_index :post_reactions, %i[user_id post_id], unique: true, if_not_exists: true
  end
end
