class Restaurant < ApplicationRecord
  CATEGORIES = %w[
    Italiano Francês Brasileiro Português Japonês Mexicano Chinês Indiano
    Mediterrâneo Vegetariano Africano Alemão Árabe
  ].freeze

  belongs_to :user

  # Associações
  has_many :ratings, dependent: :destroy
  has_many :checkins, dependent: :destroy   # <<< ADICIONADO
  has_one_attached :photo

  # Validações
  validates :name, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :infos, presence: true

  # price_range será um número (1 barato, 2 médio, 3 caro)
end
