class User < ApplicationRecord
  has_many :restaurants, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_reactions, dependent: :destroy

  has_one_attached :profile_picture

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[customer owner].freeze
  validates :role, inclusion: { in: ROLES }, allow_nil: true
  validates :username, presence: true, on: :update

  has_many :active_friendships, class_name: "Friendship", foreign_key: :user_id, dependent: :destroy
  has_many :following, through: :active_friendships, source: :followed

  has_many :passive_friendships, class_name: "Friendship", foreign_key: :friend_id, dependent: :destroy
  has_many :followers, through: :passive_friendships, source: :follower

  def customer?
    role == "customer"
  end

  def owner?
    role == "owner"
  end

  def following?(other_user)
    following.exists?(other_user.id)
  end
end
