class Rating < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  validates :score, presence: true, inclusion: { in: 1..5 }
end
