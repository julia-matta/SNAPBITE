class Restaurant < ApplicationRecord
  CATEGORIES = %w[Italiano Francês Brasileiro Português Japonês Mexicano Chinês Indiano Mediterrâneo Vegetariano Africano Alemão Árabe].freeze

  has_many :ratings, dependent: :destroy
  belongs_to :user
  has_one_attached :photo

  validates :name, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :infos, presence: true

  # price_range será um número (1 barato, 2 médio, 3 caro)
end
