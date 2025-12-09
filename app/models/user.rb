class User < ApplicationRecord
  has_many :restaurants, dependent: :destroy
  has_many :ratings, dependent: :destroy

  has_many :friendships
  has_many :friends, through: :friendships

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[customer owner].freeze

  validates :role, inclusion: { in: ROLES }, allow_nil: true
  validates :username, presence: true, on: :update

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
