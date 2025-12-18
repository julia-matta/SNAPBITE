class Restaurant < ApplicationRecord
  CATEGORIES = %w[
    Italiano Francês Brasileiro Português Japonês Mexicano Chinês Indiano
    Mediterrâneo Vegano Alemão Árabe
  ].freeze

  belongs_to :user

  has_many :ratings, dependent: :destroy
  has_many :checkins, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :infos, presence: true

  after_create_commit :create_owner_post

  private

  def create_owner_post
    Post.create!(
      user: user,
      restaurant: self,
      caption: "Novo restaurante cadastrado: #{name}"
    )
  end
end
