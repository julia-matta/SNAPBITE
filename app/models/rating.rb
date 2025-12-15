class Rating < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  # score geral de 1 a 5
  validates :score, presence: true, inclusion: { in: 1..5 }

  # enviroment / service / food_text / price são opcionais
  # (o usuário escolhe se quer avaliar esses aspectos ou não)

   after_create_commit :create_feed_post

  private

  def create_feed_post
    Post.create!(
      user: user,
      restaurant: restaurant,
      caption: comment.presence || "Avaliou #{restaurant.name}",
      rating: score
    )
  end
end
