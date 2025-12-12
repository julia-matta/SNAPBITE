class Checkin < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  # validação simples (garante que usuário e restaurante existam)
  validates :user, presence: true
  validates :restaurant, presence: true
end
