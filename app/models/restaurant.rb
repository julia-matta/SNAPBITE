class Restaurant < ApplicationRecord
  has_many :ratings, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :category, presence: true, inclusion: { in: %w[Italiano Francês Brasileiro Português Japonês Mexicano Chinês Indiano Mediterrâneo Vegetariano Árabe] }
  validates :infos, presence: true
end
