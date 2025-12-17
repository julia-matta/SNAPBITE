class PostReaction < ApplicationRecord
  belongs_to :user
  belongs_to :post

  enum :reaction_type, { recommend: 0, not_recommend: 1 }

  validates :reaction_type, presence: true
  validates :user_id, uniqueness: { scope: :post_id }
end
