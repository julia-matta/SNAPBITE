class Friendship < ApplicationRecord
  belongs_to :follower, class_name: "User", foreign_key: :user_id
  belongs_to :followed, class_name: "User", foreign_key: :friend_id

  validates :followed, uniqueness: { scope: :follower }
end
