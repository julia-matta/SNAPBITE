class Post < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many_attached :photos

  validates :caption, presence: true
end
