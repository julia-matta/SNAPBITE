class Post < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many_attached :photos
  has_many :comments, dependent: :destroy
  has_many :post_reactions, dependent: :destroy

  validates :caption, presence: true

  after_create_commit :register_checkin, if: :check_in?

  private

  def register_checkin
    restaurant.checkins.create!(user: user)
  end
end
