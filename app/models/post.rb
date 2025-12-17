class Post < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many_attached :photos
  has_many :comments, dependent: :destroy
  has_many :post_reactions, dependent: :destroy

  validates :caption, presence: true
end
