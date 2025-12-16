class AddMenuTimesToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :menu_times, :text, array: true, default: [], null: false
  end
end
