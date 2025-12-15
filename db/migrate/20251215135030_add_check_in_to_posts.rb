class AddCheckInToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :check_in, :boolean, default: false, null: false
  end
end
