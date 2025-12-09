class User < ApplicationRecord
  has_many :restaurants, dependent: :destroy
  has_many :ratings, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[customer owner].freeze

  validates :role, inclusion: { in: ROLES }

  def customer?
    role == "customer"
  end

  def owner?
    role == "owner"
  end

end
