class User < ApplicationRecord
  has_many :restaurants, dependent: :destroy
  has_many :ratings, dependent: :destroy

  has_many :friendships
  has_many :friends, through: :friendships

  has_one_attached :profile_picture

  has_many :posts, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[customer owner].freeze

  validates :role, inclusion: { in: ROLES }, allow_nil: true
  validates :username, presence: true, on: :update

  has_many :comments, dependent: :destroy

  def customer?
    role == "customer"
  end

  def owner?
    role == "owner"
  end

  def following?(other_user)
    friends.include?(other_user)
  end

end
